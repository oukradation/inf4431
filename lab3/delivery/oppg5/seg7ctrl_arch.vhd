library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.subprog_pck.all;

architecture beh of seg7ctrl is 
signal counter : std_logic_vector(1 downto 0) := (others => '0');
begin 
   process(reset,mclk) is
   begin
      if (reset = '1') then 
         counter <= (others => '0');
		 a_n <= (others => '0');
		 
		
      elsif rising_edge(mclk) then 
         case counter(counter'length - 1 downto counter'length - 2) is
		      when "00" => 
				    a_n <= "1110";
				    abcdefgdec_n <= hex2seg7(d0,dec(0));
		      when "01" => 
		            a_n <= "1101"; -- velger display
				    abcdefgdec_n <= hex2seg7(d1,dec(1)); -- bestemmer hva som vises
		      when "10" => 
		            a_n <= "1011";
				    abcdefgdec_n <= hex2seg7(d2,dec(2));
		      when others => 
		            a_n <= "0111";
				    abcdefgdec_n <= hex2seg7(d3,dec(3));
        end case;
          counter <= std_logic_vector(unsigned(counter)+1);
      end if;
   end process;
end beh;

