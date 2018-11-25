library ieee;
use ieee.std_logic_1164.all;

entity cru is
  port
  (
    arst      : in  std_logic;  -- async.reset
    refclk    : in  std_logic;  -- ref clock
    rst       : out std_logic;  -- sync arst for mclk
    rst_div   : out std_logic;  -- sync arst for mclk_div
    mclk      : out std_logic;
    mclk_div  : out std_logic   -- mclk/128
  );

end entity cru;
