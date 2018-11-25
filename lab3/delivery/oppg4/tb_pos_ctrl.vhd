library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_ctrl is
end entity;

architecture tb of tb_pos_ctrl is
   component pos_ctrl is
      port (
    -- System Clock and Reset
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
    force_ccw : in  std_logic;  -- Force motor counter clock wise motion
    motor_cw  : out std_logic;          -- Motor clock wise motion
    motor_ccw : out std_logic           -- Motor counter clock wise motion
    );         
    end component;
component motor is
       generic
	        (phase90 : time := 50 ns);
       port (
         motor_cw  : in  std_logic;
         motor_ccw : in  std_logic;
         a         : out std_logic;
         b         : out std_logic
             ); 
end component;

signal rst         : std_logic             := '0';
signal rst_div     : std_logic             := '0';
signal mclk        : std_logic             := '0';
signal mclk_div    : std_logic             := '0';
signal sync_rst    : std_logic             := '0';
signal sp          : std_logic_vector(7 downto 0) := (others => '0');
signal a           : std_logic             := '0';
signal b           : std_logic             := '0';
signal pos         : std_logic_vector(7 downto 0) := (others => '0');
signal force_cw    : std_logic             := '0';
signal force_ccw   : std_logic             := '0';
signal motor_cw    : std_logic             := '0';
signal motor_ccw   : std_logic             := '0';
-- setter klokkeperioder
constant Half_Period_mclk : time := 10 ns;
constant Half_Period_mclk_div : time := 5 ns;

begin
pos_ctrl_map: pos_ctrl port map(rst,rst_div,mclk,mclk_div,sync_rst,sp,a,b,pos,force_cw,force_ccw,motor_cw,motor_ccw);
motor_map: motor generic map(phase90 => 50 ns) port map(motor_cw,motor_ccw,a,b);

mclk_div <= not mclk_div after Half_Period_mclk_div;
mclk <= not mclk after Half_Period_mclk;

STIMULI: process
   begin
      wait for 10 ns;
      rst <= '1', '0' after 20 ns;
      rst_div <= '1','0' after 20 ns;
	  sync_rst <= '1', '0' after 20 ns;  
	  wait for 100 ns;
	  sp <= std_logic_vector(to_signed(9,8)); -- sp = 9. 8 bit
	  force_cw <= '1';
	  force_ccw <= '0';
	  wait for 1 us;
	  force_cw <= '0';
	  force_ccw <= '1';
	  wait for 1 us;
	  force_cw <= '0';
	  force_ccw <= '0';
      wait for 2 us;
	  sp <= std_logic_vector(to_signed(3,8)); -- sp = 3, 8 bit
	  wait;
   end process;

end architecture tb;