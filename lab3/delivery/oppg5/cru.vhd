library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library unisim;
use unisim.all;

entity cru is
   port(
   arst       : in std_logic; --asynch reset, global reset
   rfclk      : in std_logic; --reference clock
   rst        : out std_logic; --synchronized arst_n for mclk
   rst_div    : out std_logic; --synchronized arst_n for mclk
   mclk       : out std_logic; -- master clock
   mclk_div   : out std_logic -- master clock div by 128
       );
end entity;

architecture bh of cru is
   component bufg
      port(i   : in std_logic;
	       o   : out std_logic
	       );
   end component;
   component rstsynch is
      port( arst     : in std_logic;
            mclk     : in std_logic;
		    mclk_div : in std_logic;
		    rst      : out std_logic;
		    rst_div  : out std_logic
          );
   end component;
   component clkdiv is
   port(rst        : in std_logic; -- toggles 128 as fats as master clock
        mclk       : in std_logic;
		mclk_div   : out std_logic
        );
   end component;
signal rst_i          : std_logic;
signal rst_local      : std_logic;
signal rst_div_local  : std_logic; 
signal rst_div_i      : std_logic;
signal mclk_i         : std_logic;
signal mclk_div_local : std_logic;
signal mclk_div_i     : std_logic;

begin

bufg_0 : bufg port map(i => rfclk,
                       o => mclk_i);
rstsynch_0 : rstsynch port map(arst => arst,
                               mclk => mclk_i,
							   mclk_div => mclk_div_i,
							   rst => rst_local,
							   rst_div => rst_div_local);
bufg_1 : bufg port map(i => rst_local,
                       o => rst_i);
bufg_2 : bufg port map(i => rst_div_local, 
                       o => rst_div_i);
clkdiv_0 : clkdiv port map(rst => rst_i,
                           mclk => mclk_i,
						   mclk_div => mclk_div_local
                           );
bufg_3 : bufg port map(i => mclk_div_local,
                       o => mclk_div_i
                       );
rst      <= rst_i;
rst_div  <= rst_div_i;
mclk     <= mclk_i;
mclk_div <= mclk_div_i;
end bh;               