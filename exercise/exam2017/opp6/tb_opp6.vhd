library ieee;
use ieee.std_logic_1164.all;

entity tb_seqgen is
end entity tb_seqgen;

architecture testbench of tb_seqgen is
  
  component seq_gen
    port
      (
        rst   : in  std_logic;
        clk   : in  std_logic;
        run   : in  std_logic;
        q     : out std_logic_vector(2 downto 0)
      );
  end component;

  signal clk : std_logic := '0';
  signal rst : std_logic;
  signal run : std_logic;
  signal q   : std_logic_vector(2 downto 0);

begin

  UUT : seq_gen
  port map
    (
      rst, clk, run, q
    );
  
  clk <= not clk after 10 ns;
  
  STIMULI : process
  begin
    rst <= '1', '0' after 100 ns;
    run <= '1';
    wait for 300 ns;
    run <= '0', '1' after 100 ns;
    wait;
  end process;


end architecture testbench;
