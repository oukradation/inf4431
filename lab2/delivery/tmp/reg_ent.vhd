library ieee;
use ieee.std_logic_1164.all;

entity reg is
  port
  (
    mclk         : in  std_logic; 
    reset        : in  std_logic;
    load         : in  std_logic;
    di           : in  std_logic_vector(3 downto 0);
    sel          : in  std_logic_vector(1 downto 0);
    abcdefgdec_n : out std_logic_vector(7 downto 0); 
    a_n          : out std_logic_vector(3 downto 0)
  );
end entity reg;
