-- Modified counter from lab1 library IEEE;
library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity TIMER is
  generic ( n : integer );
  port
  (
   MCLK      : in std_logic;      -- klokkesignal fra pushbutton
   RESET     : in std_logic;      -- asynkron reset
   COUNT     : out std_logic_vector(n-1 downto 0) -- telleverdi
  );
end TIMER;

architecture TELLER of TIMER is
   signal COUNT_I : unsigned(n-1 downto 0);

begin
    COUNTER:
    process(RESET,MCLK)
    begin
      if(RESET = '1') then
        COUNT_I <= (others => '0');
      elsif rising_edge(MCLK) then
          COUNT_I <= COUNT_I + 1;
      end if;
    end process COUNTER;

    COUNT <= std_logic_vector(COUNT_I);
end TELLER;
