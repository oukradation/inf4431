library IEEE;
use IEEE.std_logic_1164.all;

entity TEST_DECODER is
end TEST_DECODER;

architecture TESTBENCH of TEST_DECODER is

    -- Test component
    Component DECODER 
        port
        (
            INP     : in  std_logic_vector(1 downto 0);
            OUTP    : out std_logic_vector(3 downto 0)
        );
    end Component;

    -- testbench signals
    signal T_INP    : std_logic_vector(1 downto 0) := "00";
    signal T_OUTP   : std_logic_vector(3 downto 0);     

begin
    UUT : DECODER
    port map
    (
        INP     =>  T_INP,
        OUTP    =>  T_OUTP
    );

    -- test stimuli
    SIMULI :
    process
    begin
        wait for 10 ns;
        T_INP <= "01";
        wait for 10 ns;
        T_INP <= "10";
        wait for 10 ns;
        T_INP <= "11";
        wait;
    end process;

end TESTBENCH;  --TESTBENCH 