library IEEE;
use IEEE.std_logic_1164.all;

entity TEST_UPDOWN_COUNTER is
end TEST_UPDOWN_COUNTER;

architecture TESTBENCH of TEST_UPDOWN_COUNTER is

    Component COUNTER
        port
        (
            UP          :   in  std_logic; 
            CLK         :   in  std_logic;
            RESET       :   in  std_logic;
            LOAD        :   in  std_logic;
            INP         :   in  std_logic_vector(3 downto 0);
            COUNT       :   out  std_logic_vector(3 downto 0);
            MAX_COUNT   :   out  std_logic;
            MIN_COUNT   :   out  std_logic
        );
    end Component;

    -- testbench internal signals
    signal  UP          : std_logic := '1';
    signal  MCLK        : std_logic := '0';
    signal  RESET       : std_logic := '0';
    signal  LOAD        : std_logic := '0';
    signal  INP         : std_logic_vector(3 downto 0) := "0000";
    signal  COUNT       : std_logic_vector(3 downto 0);
    signal  MAX_COUNT   : std_logic;
    signal  MIN_COUNT   : std_logic;

    constant Half_Period: time := 10 ns;

begin
    UUT : COUNTER
    port map
    (
        UP         => UP,
        CLK        => MCLK,
        RESET      => RESET,
        LOAD       => LOAD,
        INP        => INP,
        COUNT      => COUNT,
        MAX_COUNT  => MAX_COUNT,
        MIN_COUNT  => MIN_COUNT
    );

    MCLK <= not MCLK after Half_Period;

    STIMULI:
    process
    begin
        -- start after half period
        RESET <= '1', '0' after Half_Period;

        -- count down for a full cycle then up
        UP <= '0', '1' after 32*Half_Period;

        -- load after full down and up
        INP <= "1010" after Half_Period*6;
        wait for 2*Half_Period*32;
        LOAD <= '1', '0' after 2*Half_Period;
        wait; 
    end process;

end TESTBENCH;

    
