library ieee;
use ieee.std_logic_1164.all;

entity tb_lfsr is
end entity tb_lfsr;

architecture testbench of tb_lfsr is
  component lfsr
    port
      (
        rst   : in  std_logic;
        clk   : in  std_logic;
        load  : in  std_logic;
        seed  : in  std_logic_vector(2 downto 0);
        run   : in  std_logic;
        q     : out std_logic_vector(2 downto 0);
        err   : out std_logic
      );
  end component;

  signal rst   : std_logic;
  signal clk   : std_logic:='0';
  signal load  : std_logic;
  signal seed  : std_logic_vector(2 downto 0);
  signal run   : std_logic;
  signal q     : std_logic_vector(2 downto 0);
  signal err   : std_logic;

begin

  UUT : lfsr port map( rst, clk, load, seed, run, q, err);

  clk <= not clk after 10 ns;

  STIMULI : process
  begin
    rst <= '1', '0' after 50 ns;
    run <= '1';
    wait for 60 ns;
    seed <= "100";
    load <= '1', '0' after 20 ns;
    wait for 500 ns;
    seed <= "000";
    load <= '1', '0' after 20 ns;
    wait for 100 ns;
    seed <= "100";
    load <= '1', '0' after 20 ns;
    wait;
  end process STIMULI;
  
end architecture testbench;
