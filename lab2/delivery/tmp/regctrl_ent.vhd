library ieee;
use ieee.std_logic_1164.all;

entity regctrl is
  port
  (
    mclk        : in  std_logic; 
    reset       : in  std_logic;
    load        : in  std_logic;
    di          : in  std_logic_vector(3 downto 0);
    sel         : in  std_logic_vector(1 downto 0);
    d0          : out std_logic_vector(3 downto 0);
    d1          : out std_logic_vector(3 downto 0);
    d2          : out std_logic_vector(3 downto 0);
    d3          : out std_logic_vector(3 downto 0);
    dec         : out std_logic_vector(3 downto 0)
  );
end entity regctrl;
