library IEEE;
use IEEE.std_logic_1164.all;

entity TEST_TIMER is
end TEST_TIMER;

architecture TB of TEST_TIMER is

  component TIMER
     port(
           CLK        : in std_logic;
           RESET      : in std_logic;
           LOAD       : in std_logic;
           INP        : in std_logic_vector(3 downto 0);
           COUNT      : out std_logic_vector(3 downto 0);
           UP         : in std_logic;
           MAX_COUNT  : out std_logic;
           MIN_COUNT  : out std_logic
         );
  end component;

  --testbenk interne signaler som skal lenkes med component TESTBENK. initialstate

  signal MCLK       : std_logic  := '0';
  signal RESET      : std_logic;
  signal LOAD       : std_logic;
  signal INP        : std_logic_vector(3 downto 0) := "0000";
  signal COUNT      : std_logic_vector(3 downto 0);
  signal UP         : std_logic;
  signal MAX_COUNT  : std_logic;
  signal MIN_COUNT  : std_logic;

  constant Half_Period : time := 10 ns; --50 MHz klokkefrekvens

begin
  UUT : TIMER
  port map
  (
    --formelt navn => faktisk navn
  CLK        => MCLK,
  RESET      => RESET,
  LOAD       => LOAD,
  INP        => INP,
  COUNT      => COUNT,
  UP         => UP,
  MAX_COUNT  => MAX_COUNT,
  MIN_COUNT  => MIN_COUNT
  );

   MCLK <= not MCLK after Half_Period;

   STIMULI :
	process
	begin
	  UP <= '1', '0' after  Half_period*40;
          RESET <= '1', '0' after 100ns;
	  INP   <= "1010" after Half_Period*6;
	  wait for 2*Half_Period*10;
	  LOAD  <= '1', '0' after 2*Half_Period;
	  wait;
	end process;
end TB;
