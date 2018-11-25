library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pkg is
  -- parity func/proc
  function parity(indata : std_logic_vector(15 downto 0)) 
           return std_logic;
  function parity(indata : unsigned(15 downto 0)) 
           return std_logic;
  procedure parity(indata : in std_logic_vector(15 downto 0);
                   par    : out std_logic);
  procedure parity(indata : in unsigned(15 downto 0);
                   par    : out std_logic);

  -- hex2seg7
  function hex2seg7(indata : std_logic_vector(3 downto 0);
                    dec    : std_logic)
                    return std_logic_vector;
end package subprog_pkg;
