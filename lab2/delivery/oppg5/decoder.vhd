-- Modified syncronous 2 to 4 bit decoder from lab1
library IEEE;
use IEEE.std_logic_1164.all;

entity DECODER is
  port
  (
    MCLK        : in  std_logic;
    RESET       : in  std_logic;
    INP         : in  std_logic_vector(1 downto 0); -- input 
    OUTP        : out std_logic_vector(3 downto 0)  -- output
  );
end DECODER;

architecture arch of DECODER is

begin
  PROC : process (mclk, reset)
  begin
    if (reset = '1')  then
      outp <= (others => '0');
    elsif rising_edge(mclk) then
      case INP is
        when "00"   => OUTP <= "1110";
        when "01"   => OUTP <= "1101";
        when "10"   => OUTP <= "1011";
        when others => OUTP <= "0111";
      end case;
    end if;
  end process PROC;
end arch ; -- arch
