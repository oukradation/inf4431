library ieee;
use ieee.std_logic_1164.all;

entity tb_clock is
--
end entity tb_clock;

architecture testbench of tb_clock is

  component top is
    port
    (
      mclk          : in  std_logic; 
      reset         : in  std_logic;
      stop          : in  std_logic;
      start         : in  std_logic;
      pause         : in  std_logic;
      abcdefgdec_n  : out std_logic_vector(7 downto 0);
      a_n           : out std_logic_vector(3 downto 0)
    );
  end component top;
  
  signal mclk          : std_logic; 
  signal reset         : std_logic;
  signal stop          : std_logic := '0';
  signal start         : std_logic := '0';
  signal pause         : std_logic := '0';
  signal abcdefgdec_n  : std_logic_vector(7 downto 0);
  signal a_n           : std_logic_vector(3 downto 0);

begin
  UUT : top
  port map
  (
    mclk    =>    mclk ,      
    reset   =>    reset,       
    stop    =>    stop ,       
    start   =>    start,       
    pause   =>    pause,       
    abcdefgdec_n => abcdefgdec_n,
    a_n => a_n
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
    wait for 1 us;
    start <= '1', '0' after 1 us;
    wait for 5 ms;
    pause <= '1', '0' after 1 us;
    wait for 5 ms;
    start <= '1', '0' after 1 us;
    wait;
  end process STIMULI;
  

end architecture testbench;
