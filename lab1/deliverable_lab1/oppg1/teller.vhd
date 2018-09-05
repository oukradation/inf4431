library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity TIMER is
   port
      (
       CLK       : in std_logic;      -- klokkesignal fra pushbutton
       RESET     : in std_logic;      -- asynkron reset
       LOAD      : in std_logic;      -- intern synkron reset
       INP       : in std_logic_vector(3 downto 0); -- startverdi
       COUNT     : out std_logic_vector(3 downto 0); -- telleverdi
       UP        : in std_logic;       -- telleretning
       MAX_COUNT : out std_logic;       -- maksimum telling
       MIN_COUNT : out std_logic        -- minimum telling
      );
end TIMER;

architecture TELLER of TIMER is
   signal COUNT_I : unsigned(3 downto 0);

begin
    COUNTER:
    process(RESET,CLK)
    begin
      if(RESET = '1') then
        COUNT_I <= "0000";
      elsif rising_edge(CLK) then
        if LOAD = '1' then
           COUNT_I <= unsigned(INP);
        elsif  UP = '1' then
            COUNT_I <= COUNT_I + 1;
        else
            COUNT_I <= COUNT_I - 1;
        end if;
      end if;
    end process COUNTER;

    COUNT <= std_logic_vector(COUNT_I);
    MAX_COUNT <= '1' when (COUNT_I = "1111" and UP = '1') else '0';
    MIN_COUNT <= '1' when (COUNT_I = "0000" and UP = '0') else '0';
end TELLER;
