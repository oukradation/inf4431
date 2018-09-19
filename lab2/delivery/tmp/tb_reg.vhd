library ieee;
use ieee.std_logic_1164.all;

entity tb_reg is
-- empty
end entity tb_reg;

architecture testbench of tb_reg is
  component reg is
    port
    (
      mclk         : in  std_logic; 
      reset        : in  std_logic;
      load         : in  std_logic;
      di           : in  std_logic_vector(3 downto 0);
      sel          : in  std_logic_vector(1 downto 0);
      abcdefgdec_n : out std_logic_vector(7 downto 0); 
      a_n          : out std_logic_vector(3 downto 0)
    );
  end component reg;
  signal mclk,reset,load : std_logic;
  signal di              : std_logic_vector(3 downto 0);
  signal sel             : std_logic_vector(1 downto 0);
  signal abcdefgdec_n    : std_logic_vector(7 downto 0); 
  signal a_n             : std_logic_vector(3 downto 0);

  constant half_period : time := 5 ns;
  
begin
  UUT : reg
  port map( 
            mclk         => mclk         ,
            reset        => reset        ,
            load         => load         ,
            di           => di           ,
            sel          => sel          ,
            abcdefgdec_n => abcdefgdec_n ,
            a_n          => a_n          
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
    di <= "0000";
    sel <= "00";
    load <= '1';
    wait for 10 us;
    di <= "0101";
    sel <= "01";
    wait for 10 us;
    di <= "0111";
    sel <= "10";
    wait for 10 us;
    di <= "0011";
    sel <= "11";
    wait;
  end process STIMULI;

end architecture testbench;

