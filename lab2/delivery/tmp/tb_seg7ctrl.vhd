library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_seg7ctrl is
-- empty
end entity tb_seg7ctrl;

architecture testbench of tb_seg7ctrl is

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
  end component seg7ctrl;

  component seg7model is
    port (
      a_n           : in  std_logic_vector(3 downto 0);
      abcdefgdec_n  : in  std_logic_vector(7 downto 0);
      disp3         : out std_logic_vector(3 downto 0);
      disp2         : out std_logic_vector(3 downto 0);
      disp1         : out std_logic_vector(3 downto 0);
      disp0         : out std_logic_vector(3 downto 0)
    );
  end component seg7model;

  signal a_n           : std_logic_vector(3 downto 0);
  signal abcdefgdec_n  : std_logic_vector(7 downto 0);
  signal disp3         : std_logic_vector(3 downto 0);
  signal disp2         : std_logic_vector(3 downto 0);
  signal disp1         : std_logic_vector(3 downto 0);
  signal disp0         : std_logic_vector(3 downto 0);

  signal mclk          : std_logic;
  signal reset         : std_logic;
  signal d0            : std_logic_vector(3 downto 0);
  signal d1            : std_logic_vector(3 downto 0);
  signal d2            : std_logic_vector(3 downto 0);
  signal d3            : std_logic_vector(3 downto 0);
  signal dec           : std_logic_vector(3 downto 0) := "0000";

  constant half_period : time := 5 ns;
 
begin
  UUT1 : seg7ctrl
  port map
  (
    mclk          =>  mclk,
    reset         =>  reset,
    d0            =>  d0,
    d1            =>  d1,
    d2            =>  d2,
    d3            =>  d3,
    dec           =>  dec,
    abcdefgdec_n  =>  abcdefgdec_n,
    a_n           =>  a_n
  );
  UUT2 : seg7model
  port map 
  (
    a_n          => a_n,         
    abcdefgdec_n => abcdefgdec_n,
    disp3        => disp3,       
    disp2        => disp2,       
    disp1        => disp1,       
    disp0        => disp0       
  );

  CLOCK : process
  begin
    mclk <= '1';
    wait for half_period;
    mclk <= '0';
    wait for half_period;
  end process CLOCK;

  STIMULI : process
  begin
    reset <= '1', '0' after 100 ns;
    d0 <= std_logic_vector(to_unsigned(3,4));
    d1 <= std_logic_vector(to_unsigned(9,4));
    d2 <= std_logic_vector(to_unsigned(2,4));
    d3 <= std_logic_vector(to_unsigned(7,4));
    wait;
  end process STIMULI;

end architecture testbench;
