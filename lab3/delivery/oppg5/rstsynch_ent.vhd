library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rstsynch is
   port( arst     : in std_logic;
         mclk     : in std_logic;
		 mclk_div : in std_logic;
		 rst      : out std_logic;
		 rst_div  : out std_logic
       );
end entity;

architecture rtl of rstsynch is
signal rst_s1,rst_s2         : std_logic;
signal rst_div_s1,rst_div_s2 : std_logic;

begin

RST_O : process (arst,mclk)
begin
   if arst = '1' then
      rst_s1 <= '1';
	  rst_s2 <= '1';
   elsif rising_edge(mclk) then
      rst_s1 <= '0';
	  rst_s2 <= rst_s1;
   end if;
   end process RST_O;
RST_1 : process (arst,mclk_div)
begin
   if arst = '1' then
      rst_div_s1 <= '1';
	  rst_div_s2 <= '1';
   elsif rising_edge(mclk_div) then
      rst_div_s1 <= '0';
	  rst_div_s2 <= rst_div_s1;
   end if;
   end process RST_1;
   
   rst <= rst_s2;
   rst_div <= rst_div_s2;
end architecture;
