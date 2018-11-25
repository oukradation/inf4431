library ieee;
use ieee.std_logic_1164.all;

entity tb_opp8 is
end entity;

architecture testbench of tb_opp8 is
  component timecalc is
    port(
      rst           : in  std_logic;
      clk_50m       : in  std_logic;
      prewash_ena   : in  std_logic;
      wash_ena      : in  std_logic;
      spin_ena      : in  std_logic;
      prewash_min   : in  std_logic_vector(7 downto 0);
      wash_min      : in  std_logic_vector(7 downto 0);
      spin_min      : in  std_logic_vector(7 downto 0);
      delay_min     : in  std_logic_vector(11 downto 0);
      completion_min: out std_logic_vector(12 downto 0)
    );
  end component;

  signal rst           : std_logic:= '0';
  signal clk           : std_logic:= '0';
  signal prewash_ena   : std_logic:= '0';
  signal wash_ena      : std_logic:= '0';
  signal spin_ena      : std_logic:= '0';
  signal prewash_min   : std_logic_vector(7 downto 0);
  signal wash_min      : std_logic_vector(7 downto 0);
  signal spin_min      : std_logic_vector(7 downto 0);
  signal delay_min     : std_logic_vector(11 downto 0);

begin

  UUT : timecalc
  port map(rst, clk, prewash_ena, wash_ena, spin_ena, prewash_min, wash_min, spin_min, delay_min);

  clk <= not clk after 10 ns;

  STIMULI : process
  begin
    rst <= '1', '0' after 50 ns;
    prewash_min <= "00000100";
    wash_min <= "00001100";
    spin_min <= "00100100";
    delay_min <= "000000000010";

    wait for 100 ns;
    prewash_ena <= '1', '0' after 500 ns;
    wash_ena <= '1', '0' after 500 ns;
    spin_ena <= '1', '0' after 500 ns;

    wait for 500 ns;
    wash_ena <= '1', '0' after 500 ns;
    spin_ena <= '1', '0' after 500 ns;

    wait;
  end process;

end architecture testbench;
