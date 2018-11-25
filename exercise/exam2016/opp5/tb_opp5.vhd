library ieee;
use ieee.std_logic_1164.all;

entity tb_opp5 is
end entity tb_opp5;

architecture testbench of tb_opp5 is

  component delaytimecalc is
  port
    (
      rst       : in  std_logic;
      clk_20m   : in  std_logic;
      delay     : in  std_logic;
      delay_val : out std_logic;
      delay_min : out std_logic_vector(11 downto 0)
    );
  end component;

  signal rst       : std_logic;
  signal clk       : std_logic:='0';
  signal delay     : std_logic;
  signal delay_val : std_logic;
  signal delay_min : std_logic_vector(11 downto 0);

begin

  UUT : delaytimecalc
  port map
  ( rst, clk, delay, delay_val, delay_min);

  clk <= not clk after 25 ns;

  STIMULI : process
  begin
    rst <= '1', '0' after 100 ns;
    wait for 100 ns;
    delay <= '1', '0' after 50 ns;

    wait until rising_edge(delay_val);
    wait for 100 ns;
    delay <= '1', '0' after 200 ns;

    wait;
  end process;
end architecture testbench;
