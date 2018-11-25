-- Test top module
-- simulate a,b signal from button on the board
-- print pos values on 7seg display

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_pos_meas is
  port
  (
    clk          : in   std_logic;
    rst          : in   std_logic;
    a            : in   std_logic;
    b            : in   std_logic;
    abcdefgdec_n : out  std_logic_vector(7 downto 0);
    a_n          : out  std_logic_vector(3 downto 0)
  );
end entity test_pos_meas;

architecture rtl of test_pos_meas is
  component pos_meas is
    port
    (
      -- System Clock and Reset
      rst      : in  std_logic;           -- Reset
      clk      : in  std_logic;           -- Clock
      sync_rst : in  std_logic;           -- Sync reset
      a        : in  std_logic;           -- From position sensor
      b        : in  std_logic;           -- From position sensor
      pos      : out signed(7 downto 0)   -- Measured position
    );      
  end component;
  component seg7ctrl is
    port
    (
      mclk          : in  std_logic;      -- 100MHz, posedge
      reset         : in  std_logic;      -- Asyncronous, active high
      d0            : in  std_logic_vector(3 downto 0);
      d1            : in  std_logic_vector(3 downto 0);
      d2            : in  std_logic_vector(3 downto 0);
      d3            : in  std_logic_vector(3 downto 0);
      dec           : in  std_logic_vector(3 downto 0);
      abcdefgdec_n  : out std_logic_vector(7 downto 0);
      a_n           : out std_logic_vector(3 downto 0)
    );
  end component;

  signal d0 : std_logic_vector(3 downto 0);
  signal d1 : std_logic_vector(3 downto 0);
  signal d2 : std_logic_vector(3 downto 0);
  signal d3 : std_logic_vector(3 downto 0);

  signal pos : signed(7 downto 0);

  signal dec      : std_logic_vector(3 downto 0);
  signal sync_rst : std_logic;

  function dec2seg( indata : signed(7 downto 0))
                    return std_logic_vector is
    variable seg4digit : std_logic_vector(15 downto 0);
  begin
    seg4digit(15 downto 12) := std_logic_vector(resize((indata / 1000) mod 10,4));
    seg4digit(11 downto 8)  := std_logic_vector(resize((indata / 100) mod 10,4));
    seg4digit(7 downto 4)   := std_logic_vector(resize((indata / 10) mod 10,4));
    seg4digit(3 downto 0)   := std_logic_vector(resize(indata mod 10,4));
    return seg4digit;
  end function dec2seg;

begin
  seg:seg7ctrl 
  port map
  (
    mclk         => clk,
    reset        => rst,
    d0           => d0, 
    d1           => d1,
    d2           => d2,
    d3           => d3,
    dec          => dec,
    abcdefgdec_n => abcdefgdec_n,
    a_n          => a_n
  );
  posi:pos_meas
  port map
  (
    rst      => rst     ,
    clk      => clk     ,
    sync_rst => sync_rst,
    a        => a       ,
    b        => b       ,
    pos      => pos     
  );

  -- latch unnecessaries
  dec <= (others => '0');
  sync_rst <= '0';

  -- decode pos to 4 digit seg7display
  DECODE : process(rst, clk) is
    variable tmp : std_logic_vector(15 downto 0);
  begin
    if rst = '1' then
      d0 <= (others => '0');
      d1 <= (others => '0');
      d2 <= (others => '0');
      d3 <= (others => '0');
    elsif rising_edge(clk) then
      tmp := dec2seg(pos);
      d3 <= tmp(15 downto 12);
      d2 <= tmp(11 downto 8);
      d1 <= tmp(7 downto 4);
      d0 <= tmp(3 downto 0);
    end if;
  end process DECODE;

end architecture rtl;
