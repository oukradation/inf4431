library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_opp11 is
end entity tb_opp11;

architecture testbench of tb_opp11 is

  component fibonacci
    generic
      (
        FIBWIDTH : natural := 32
      );
    port
      (
        rst     : in  std_logic;
        clk     : in  std_logic;
        run     : in  std_logic;
        funcsel : in  std_logic_vector(2 downto 0);
        nmax    : in  std_logic_vector(7 downto 0);
        inum    : out std_logic_vector(7 downto 0);
        rdy     : out std_logic;
        fn      : out std_logic_vector(FIBWIDTH-1 downto 0)
      );
  end component;

  constant MYMAX : natural := 20;
  type fibofasit is array ( 0 to MYMAX - 1 ) of natural;
  signal myfasit : fibofasit := (0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,619,987,1597,2584,4181);

  signal rst     : std_logic;
  signal clk     : std_logic := '0';
  signal run     : std_logic;
  signal funcsel : std_logic_vector(2 downto 0);
  signal nmax    : std_logic_vector(7 downto 0);
  signal inum    : std_logic_vector(7 downto 0);
  signal rdy     : std_logic;
  signal fn      : std_logic_vector(MYMAX-1 downto 0);
 
begin
  UUT : fibonacci
  generic map( MYMAX)
  port map(rst, clk, run, funcsel, nmax, inum, rdy, fn);

  clk <= not clk after 10 ns;

  STIMULI : process
  begin
    rst <= '1', '0' after 20 ns;
    funcsel <= "001";
    run <= '1';
    nmax <= std_logic_vector(to_unsigned(MYMAX, nmax'length));

    for i in 0 to MYMAX-1 loop
      wait until rising_edge(rdy);
      if std_logic_vector(to_unsigned(myfasit(i), fn'length)) = fn then
        report "correct";
      end if;
      assert std_logic_vector(to_unsigned(myfasit(i), fn'length)) = fn
        report "Error"
        severity WARNING;
    end loop;
    
    run <= '0';
    
    wait;
  end process;

end architecture testbench;
