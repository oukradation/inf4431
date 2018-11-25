library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.subprog_pck.all;

entity pargen is 
  port (
    rst_n        : in  std_logic;
    mclk         : in  std_logic;
    indata1      : in  std_logic_vector(15 downto 0);
    indata2      : in  unsigned(15 downto 0);
    par          : out std_logic);  
end pargen;

architecture rtl1 of pargen is
signal par1,outdata1,outdata2: std_logic := '0';
begin  
  process (rst_n, mclk) is    
    begin
    if (rst_n = '0') then       
      par <= '0';
    elsif rising_edge(mclk) then
      par <= parg(indata1) xor parg(indata2);
    end if;
  end process;
 
  process (rst_n, mclk) is    
    
  begin
    if (rst_n = '0') then       
      
      par1 <= '0';
    elsif rising_edge(mclk) then
	  parg(indata1,outdata1);
	  parg(indata2,outdata2);
      par1 <= outdata1 xor outdata2;
	  
    end if;
  end process;
 end rtl1;