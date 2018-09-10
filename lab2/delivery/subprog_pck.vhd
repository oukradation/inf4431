library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pkg is
  function parity(indata : std_logic_vector(15 downto 0)) 
           return std_logic;
  function parity(indata : unsigned(15 downto 0)) 
           return std_logic;
  procedure parity(indata : in std_logic_vector(15 downto 0);
                   par    : out std_logic);
  procedure parity(indata : in unsigned(15 downto 0);
                   par    : out std_logic);
end package subprog_pkg;

package body subprog_pkg is
  -- inverting
  function parity(indata : std_logic_vector(15 downto 0)) 
           return std_logic is
    -- internal variable
    variable par_i : std_logic := '0';
  begin
    for i in indata'range loop
      if indata(i) = '1' then
        par_i := not par_i;
      end if;
    end loop;
    return par_i;
  end parity;

  -- xor overload with input as unsigned type
  function parity(indata : unsigned(15 downto 0)) 
           return std_logic is
    -- internal variable
    variable par_i : std_logic := '0';
  begin
    for i in indata'range loop
      par_i := par_i xor indata(i);
    end loop;
    return par_i;
  end parity;

  ---- procedure definition
  -- inverting
  procedure parity(indata : in std_logic_vector(15 downto 0);
                   par    : out std_logic) is
  -- internal variable
  variable par_i : std_logic := '0';
  
  begin
    for i in indata'range loop
      if indata(i) = '1' then
        par_i := not par_i;
      end if;
    end loop;
    par := par_i;
  end parity;

  -- xor overload with input as unsigned type
  procedure parity(indata : in unsigned(15 downto 0);
                   par    : out std_logic) is
  -- internal variable
  variable par_i : std_logic := '0';
  
  begin
    for i in indata'range loop
      par_i := par_i xor indata(i);
    end loop;
    par := par_i;
  end parity;

end package body subprog_pkg;
