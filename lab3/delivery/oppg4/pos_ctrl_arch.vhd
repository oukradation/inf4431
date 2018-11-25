library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture beh of pos_ctrl is

signal cw         : std_logic;           -- from p_ctrl
signal ccw        : std_logic;           -- from p_ctrl
signal sp_int     : signed(7 downto 0);
signal pos_int    : signed(7 downto 0);
signal a_int      : std_logic;
signal b_int      : std_logic;

-- innhenting av komponeneter
component p_ctrl is
      port(
	       rst_div    : in std_logic;
		   mclk_div   : in std_logic;
		   sp         : in signed(7 downto 0);
	       pos        : in signed(7 downto 0);
		   motor_cw   : out std_logic;
		   motor_ccw  : out std_logic
	      );
   end component;
 
component pos_meas is
  port (
    -- System Clock and Reset
    rst      : in  std_logic;           -- Reset 
    clk      : in  std_logic;           -- Clock
    sync_rst : in  std_logic;           -- Sync reset, eksternt signal, asynkront
    a        : in  std_logic;           -- From position sensor, eksternt signal, asynkront
    b        : in  std_logic;           -- From position sensor, eksternt signal, asynkront
    pos      : out signed(7 downto 0)   -- Measured position
       );      
end component;

begin
sp_int <= signed('0' & sp(6 downto 0)); -- input sendes til internt signal, 8. bit maskeres bort
pos <= std_logic_vector(pos_int); -- internt signal sendes til output

p_ctrl_map:  p_ctrl port map(rst_div,mclk_div,sp_int,pos_int,cw,ccw);
pos_meas_map: pos_meas port map(rst,mclk,sync_rst,a,b,pos_int);

-- implementerer multiplexer
process(force_cw,force_ccw,cw,ccw)
begin

   if force_cw = '0' and force_ccw = '1' then
      motor_cw <= force_cw;
	  motor_ccw <= force_ccw;
   elsif force_cw = '1' and force_ccw = '0' then
      motor_cw <= force_cw;
	  motor_ccw <= force_ccw;
   else
      motor_cw <= cw;
	  motor_ccw <= ccw;
   end if;
end process;

end architecture;