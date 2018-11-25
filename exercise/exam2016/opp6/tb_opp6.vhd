library ieee;
use ieee.std_logic_1164.all;

entity tb_opp6 is
end;

architecture testbench of tb_opp6 is

  component sync is
    port
      (
        rst       : in  std_logic;
        clk_50m   : in  std_logic;
        delay_ena : in  std_logic;
        delay_val : in  std_logic;
        delay_min : in  std_logic_vector(11 downto 0);
        delay_time: out std_logic_vector(11 downto 0)
      );
  end component;
  
  signal rst       :  std_logic;
  signal clk       :  std_logic:='0';
  signal delay_ena :  std_logic:='0';
  signal delay_val :  std_logic:='0';
  signal delay_min :  std_logic_vector(11 downto 0):="000000000100";
  signal delay_time:  std_logic_vector(11 downto 0);

begin

  UUT : sync
  port map(rst, clk, delay_ena, delay_val, delay_min, delay_time);

  clk <= not clk after 10 ns;

  STIMULI:process
  begin
    rst <= '1', '0' after 50 ns;
    wait for 60 ns;
    delay_ena <= '1';
    wait for 100 ns;
    delay_val <= '1', '0' after 50 ns;

    wait;
  end process;

end;
