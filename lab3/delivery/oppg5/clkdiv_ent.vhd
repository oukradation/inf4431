library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 -- toggles 128 as fats as master clock
entity clkdiv is
   port(rst        : in std_logic; 
        mclk       : in std_logic;
		mclk_div   : out std_logic
        );
end entity;

architecture str of clkdiv is
   signal mclk_count : unsigned(6 downto 0);
begin
      
MCLK_DIV_PRO : process(rst,mclk)
begin
   if rst = '1' then
      mclk_count <= (others => '0');
   elsif rising_edge(mclk) then
      mclk_count <= (mclk_count + 1); 
   end if;
end process MCLK_DIV_PRO;

mclk_div <= std_logic(mclk_count(6));
     
end architecture;