library ieee;
use ieee.std_logic_1164.all;

architecture rtl of regctrl is
begin
  process (mclk, reset) is
  begin

    if (reset = '1') then
      d0  <= (others => '0');
      d1  <= (others => '0');
      d2  <= (others => '0');
      d3  <= (others => '0');
      dec <= (others => '0');

    elsif rising_edge(mclk) then
      if (load = '1') then
        case sel is
          when "00"   => d0 <= di; 
          when "01"   => d1 <= di; 
          when "10"   => d2 <= di; 
          when others => d3 <= di;
        end case;
      end if;
    
    end if;

  end process;

end architecture rtl;
