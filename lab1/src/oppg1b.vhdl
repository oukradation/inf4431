library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- up/down 4-bit counter
entity COUNTER is
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
end COUNTER;
    
architecture FIRST_ARCH of COUNTER is
    signal COUNT_I : unsigned(3 downto 0);

begin

    UPDOWN_COUNTER:
    process (RESET,CLK)
    begin
        if(RESET = '1') then
            COUNT_I <= "0000";
        elsif rising_edge(CLK) then
            if LOAD = '1' then
                COUNT_I <= unsigned(INP);
            elsif UP = '1' then
                COUNT_I <= COUNT_I + 1;
            else
                COUNT_I <= COUNT_I - 1;
            end if;
            
            -- syncronous max/min count for 1 clock period
            if (COUNT_I = "1110") and (UP = '1') then
                MAX_COUNT <= '1';
            else
                MAX_COUNT <= '0';
            end if;
            if (COUNT_I = "0001") and (UP = '0') then
                MIN_COUNT <= '1';
            else
                MIN_COUNT <= '0';
            end if;
        end if;
    end process UPDOWN_COUNTER;

    --send internal count value to COUNT, out signal
    COUNT <= std_logic_vector(COUNT_I);


end FIRST_ARCH;
