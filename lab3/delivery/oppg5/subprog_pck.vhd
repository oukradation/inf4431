library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pck is 
  function parg (indata: std_logic_vector(15 downto 0))
     return std_logic;
  
  function parg (indata: unsigned(15 downto 0))
     return std_logic;
  function hex2seg7 (Di: std_logic_vector(3 downto 0);Dec: std_logic)
     return std_logic_vector;
     
  procedure parg (signal indata: std_logic_vector; signal data_out: out std_logic);
  procedure parg (signal indata: unsigned; signal data_out: out std_logic);
end package;
  
  
 package body subprog_pck is
 function parg(indata: std_logic_vector(15 downto 0)) return std_logic is
    variable parity : std_logic := '0';
	begin
	   for i in indata'range loop
        if indata(i) = '1' then
          parity := not parity;
        end if;
       end loop;  
       return parity;
 end parg;
 
 
 function parg(indata: unsigned(15 downto 0)) return std_logic is
    variable parity : std_logic := '0';
       begin
         for j in indata'range loop
           parity := parity xor indata(j); 
         end loop;
	return parity;
 end parg;
 
 function hex2seg7(Di: std_logic_vector(3 downto 0); Dec: std_logic) return std_logic_vector is
    variable out_data : std_logic_vector(6 downto 0) := "0000000"; 

   begin    
      case Di is
        when "0000" => out_data := "0000001";            --X"30"; 0
        when "0001" => out_data := "1001111";            --X"31"; 1
        when "0010" => out_data := "0010010";            --X"32"; 2
        when "0011" => out_data := "0000110";            --X"33"; 3
        when "0100" => out_data := "1001100";            --X"34"; 4
        when "0101" => out_data := "0100100";            --X"35"; 5
        when "0110" => out_data := "0100000";            --X"36"; 6
        when "0111" => out_data := "0001111";            --X"37"; 7
        when "1000" => out_data := "0000000";            --X"38"; 8
        when "1001" => out_data := "0001100";            --X"39"; 9
        when "1010" => out_data := "0001000";            --X"41"; A
        when "1011" => out_data := "1100000";            --X"42"; B
        when "1100" => out_data := "0110001";            --X"43"; C
        when "1101" => out_data := "1000010";            --X"44"; D
        when "1110" => out_data := "0110000";            --X"45"; E
        when "1111" => out_data := "0111000";            --X"46"; F
        when others => out_data := "XXXXXXX";
--      
     end case;
--  end process encode;
    return out_data & not Dec; 
end hex2seg7;

 procedure parg (signal indata: std_logic_vector; signal data_out: out std_logic) is
 variable parity : std_logic := '0';
  begin
    for i in indata'range loop
	 if indata(i) = '1' then
	    parity := not parity;
	 end if;
    end loop;
	data_out <= parity;
end parg;
 procedure parg (signal indata: unsigned; signal data_out: out std_logic) is
 variable parity : std_logic := '0';
  begin
     for j in indata'range loop
        parity := parity xor indata(j);
     end loop;
	 data_out <= parity;
end parg;
 
   
 end package body;
  
  
   
  
  
  					
  
