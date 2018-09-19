library ieee;
use ieee.std_logic_1164.all;

entity seg7ctrl is
  port
  (
    mclk          : in  std_logic;      -- 100MHz, posedge
    reset         : in  std_logic;      -- Asyncronous, active high
    d0            : in  std_logic_vector(3 downto 0);
    d1            : in  std_logic_vector(3 downto 0);
    d2            : in  std_logic_vector(3 downto 0);
    d3            : in  std_logic_vector(3 downto 0);
    dec           : in  std_logic_vector(3 downto 0);
    abcdefgdec_n  : out std_logic_vector(7 downto 0);
    a_n           : out std_logic_vector(3 downto 0)
  );
end entity seg7ctrl;
