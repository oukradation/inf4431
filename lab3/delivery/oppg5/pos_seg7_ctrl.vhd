library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture beh of pos_seg7_ctrl is
signal pos_int,sp_int,abcdefgdec_n_int : std_logic_vector(7 downto 0); 
signal dec,a_n_int : std_logic_vector(3 downto 0) := "0000"; 
signal rst_int,rst_div_int,mclk_int,mclk_div_int : std_logic; 
   component pos_ctrl is
      port(
	      rst       : in  std_logic;          -- Reset
          rst_div   : in  std_logic;          -- Reset
          mclk      : in  std_logic;          -- Clock
          mclk_div  : in  std_logic;          -- Clock to p_reg
          sync_rst  : in  std_logic;          -- Synchronous reset
          sp        : in  std_logic_vector(7 downto 0);  -- Setpoint (wanted position)
          a         : in  std_logic;          -- From position sensor
          b         : in  std_logic;          -- From position sensor
          pos       : out std_logic_vector(7 downto 0);  -- Measured Position
          force_cw  : in  std_logic;          -- Force motor clock wise motion
          force_ccw : in  std_logic;          -- Force motor counter clock wise motion
          motor_cw  : out std_logic;          -- Motor clock wise motion
          motor_ccw : out std_logic           -- Motor counter clock wise motion
	       );
   end component;

   component seg7ctrl is
      port(
	     mclk          : in std_logic;                    --100 Mhz
         reset         : in std_logic;                    --asynkron reset, active high
		 d0            : in std_logic_vector(3 downto 0); --tar interne signaler, 
		 d1            : in std_logic_vector(3 downto 0);
		 d2            : in std_logic_vector(3 downto 0);
		 d3            : in std_logic_vector(3 downto 0);
         dec           : in std_logic_vector(3 downto 0);
         abcdefgdec_n  : out std_logic_vector(7 downto 0);
		 a_n           : out std_logic_vector(3 downto 0)
	      );
   end component;

   component cru is
      port(
         arst       : in std_logic;  --asynch reset, global reset
         rfclk      : in std_logic;  --reference clock
         rst        : out std_logic; --synchronized arst_n for mclk
         rst_div    : out std_logic; --synchronized arst_n for mclk
         mclk       : out std_logic; -- master clock
         mclk_div   : out std_logic  -- master clock div by 128
          );
   end component;

begin 
   
pos_ctrl_map: pos_ctrl port map(rst_int,
								rst_div_int,
								mclk_int,
								mclk_div_int,
								sync_rst,
								sp_int,
								a,
								b,
								pos_int,
								force_cw,
								force_ccw,
								motor_cw,
								motor_ccw);
seg7_ctrl_map: seg7ctrl port map(mclk_int,
								rst_int,
								pos_int(3 downto 0),
								pos_int(7 downto 4),
								sp_int(3 downto 0),
								sp_int(7 downto 4),
								dec,
								abcdefgdec_n_int,
								a_n_int);   
cru_map : cru port map(arst,refclk,rst_int,rst_div_int,mclk_int,mclk_div_int);
abcdefgdec_n <= abcdefgdec_n_int;
a_n <= a_n_int;
sp_int <= sp;
 
 
end architecture;   