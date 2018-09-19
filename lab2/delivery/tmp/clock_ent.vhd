library ieee;
use ieee.std_logic_1164.all;

entity clock is
  port
  (
    mclk        : in  std_logic; 
    reset       : in  std_logic;
    stop        : in  std_logic;
    start       : in  std_logic;
    pause       : in  std_logic;
    d0          : out std_logic_vector(3 downto 0);
    d1          : out std_logic_vector(3 downto 0);
    d2          : out std_logic_vector(3 downto 0);
    d3          : out std_logic_vector(3 downto 0);
    dec         : out std_logic_vector(3 downto 0)
  );
end entity clock;
