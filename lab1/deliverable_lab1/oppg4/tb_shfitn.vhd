library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity TESTBENCH is
end TESTBENCH;

architecture tb of TESTBENCH is

  component SHIFTN
    generic ( N : integer );
    port
    (
      RST_N     :   IN  STD_LOGIC;
      CLK       :   IN  STD_LOGIC;
      DIN       :   IN  STD_LOGIC;
      DOUT      :   OUT STD_LOGIC_VECTOR(N-1 downto 0)
    );
  end component;
  
  -- stimuli
  signal   MCLK         : STD_LOGIC := '0';
  signal   RST_N        : STD_LOGIC;
  signal   DIN        : STD_LOGIC;
  signal   DOUT       : STD_LOGIC_VECTOR(63 downto 0); -- 64 bit output

  -- clock frequency
  constant half_period  : time := 10 ns;

begin
  UUT : SHIFTN
  generic map( N => 64 )
  port map
  (
    RST_N =>    RST_N,
    CLK   =>    MCLK,
    DIN   =>    DIN,
    DOUT  =>    DOUT
  );
  
  -- define clock
  MCLK <= not MCLK after half_period;
  
  STIMULI : process
  begin
    RST_N <= '0', '1' after 10*half_period;
    DIN <= '0';
    wait for 20*half_period;
    DIN <= '1';
    wait for 4*half_period;
    DIN <= '0';
    
    wait;
  end process;

end tb;
