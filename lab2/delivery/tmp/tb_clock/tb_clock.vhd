library ieee;
use ieee.std_logic_1164.all;

entity tb_clock is
--
end entity tb_clock;

architecture testbench of tb_clock is
  component clock is
  port
  (
    mclk        : in  std_logic; 
    reset       : in  std_logic;
    stop        : in  std_logic;
    start       : in  std_logic;
    d0          : out std_logic_vector(3 downto 0);
    d1          : out std_logic_vector(3 downto 0);
    d2          : out std_logic_vector(3 downto 0);
    d3          : out std_logic_vector(3 downto 0);
    dec         : out std_logic_vector(3 downto 0)
  );
  end component clock;
  
  signal mclk        : std_logic; 
  signal reset       : std_logic;
  signal stop        : std_logic := '0';
  signal start       : std_logic := '0';
  signal d0          : std_logic_vector(3 downto 0);
  signal d1          : std_logic_vector(3 downto 0);
  signal d2          : std_logic_vector(3 downto 0);
  signal d3          : std_logic_vector(3 downto 0);
  signal dec         : std_logic_vector(3 downto 0);

begin
  UUT : clock
  port map
  (
    mclk    =>    mclk ,      
    reset   =>    reset,       
    stop    =>    stop ,       
    start   =>    start,       
    d0      =>    d0   ,       
    d1      =>    d1   ,       
    d2      =>    d2   ,       
    d3      =>    d3   ,       
    dec     =>    dec         
  );

  CLK : process is
  begin
    mclk <= '1';
    wait for 5 ns;
    mclk <= '0';
    wait for 5 ns;
  end process CLK;

  STIMULI : process is
  begin
    reset <= '1', '0' after 100 ns;
    wait for 150 ns;
    start <= '1', '0' after 50 ns;
    wait for 5 ms;
    stop <= '1', '0' after 50 ns;
    wait;

  end process STIMULI;
  

end architecture testbench;
