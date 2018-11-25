library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_compute is
end entity tb_compute;

architecture testbench of tb_compute is
  component compute
  port
    (
      rst     : in  std_logic;
      clk     : in  std_logic;
      a       : in  std_logic_vector(15 downto 0);
      b       : in  std_logic_vector(15 downto 0);
      c       : in  std_logic_vector(15 downto 0);
      d       : in  std_logic_vector(15 downto 0);
      result  : out std_logic_vector(15 downto 0);
      max     : out std_logic
    );
  end component;

  signal rst     : std_logic;
  signal clk     : std_logic:='0';
  signal a       : std_logic_vector(15 downto 0);
  signal b       : std_logic_vector(15 downto 0);
  signal c       : std_logic_vector(15 downto 0);
  signal d       : std_logic_vector(15 downto 0);
  signal result  : std_logic_vector(15 downto 0);
  signal max     : std_logic;

begin
  UUT : compute port map( rst, clk, a,b,c,d,result, max);

  clk <= not clk after 10 ns;

  STIMULI : process
  begin
    rst <= '1', '0' after 50 ns;
    a <= std_logic_vector(to_unsigned(12,16));
    b <= std_logic_vector(to_unsigned(12,16));
    c <= std_logic_vector(to_unsigned(12,16));
    d <= std_logic_vector(to_unsigned(12,16));
    wait for 100 ns;

    a <= std_logic_vector(to_unsigned(65535,16));
    b <= std_logic_vector(to_unsigned(65535,16));
    c <= std_logic_vector(to_unsigned(65535,16));
    d <= std_logic_vector(to_unsigned(65535,16));
    wait;
  end process;
end architecture testbench;
