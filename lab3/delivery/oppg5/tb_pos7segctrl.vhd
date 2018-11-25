library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_pos7segctrl is
end entity;

architecture tb of tb_pos7segctrl is

   component pos_seg7_ctrl is
  port (
    -- System Clock and Reset
    arst         : in  std_logic;       -- Reset
    sync_rst     : in  std_logic;       -- Synchronous reset 
    refclk       : in  std_logic;       -- Clock
    sp           : in  std_logic_vector(7 downto 0);  -- Set Point
    a            : in  std_logic;       -- From position sensor
    b            : in  std_logic;       -- From position sensor
    force_cw     : in  std_logic;       -- Force motor clock wise motion
    force_ccw    : in  std_logic;       -- Force motor counter clock wise motion
    motor_cw     : out std_logic;       -- Motor clock wise motion
    motor_ccw    : out std_logic;       -- Motor counter clock wise motion
    -- Interface to seven segments
    abcdefgdec_n : out std_logic_vector(7 downto 0);
    a_n          : out std_logic_vector(3 downto 0)
    );
end component;
   
   component seg7model is 
   port
  (
    a_n           : in  std_logic_vector(3 downto 0);
    abcdefgdec_n  : in  std_logic_vector(7 downto 0);
    disp3         : out std_logic_vector(3 downto 0);
    disp2         : out std_logic_vector(3 downto 0);
    disp1         : out std_logic_vector(3 downto 0);
    disp0         : out std_logic_vector(3 downto 0)
  );
   end component;
   component motor is
  generic (
    phase90 : time := 50 us
    );
  port (
    motor_cw  : in  std_logic;
    motor_ccw : in  std_logic;
    a         : out std_logic;
    b         : out std_logic
    );      
end component;
signal a,b,motor_cw,motor_ccw,arst,sync_rst,force_cw,force_ccw,refclk : std_logic := '0';
signal sp,abcdefgdec_n : std_logic_vector(7 downto 0) := (others => '0');   
signal a_n,disp3,disp2,disp1,disp0 : std_logic_vector(3 downto 0) := (others => '0');
constant Half_Period :  time := 10 ns;
begin

pos_seg7_ctrl_map : pos_seg7_ctrl port map(arst,sync_rst,refclk,sp,a,b,force_cw,
                    force_ccw,motor_cw,motor_ccw,abcdefgdec_n,a_n);
seg7model_map     : seg7model port map(
    a_n           => a_n,
    abcdefgdec_n  => abcdefgdec_n,
    disp3         => disp3,
    disp2         => disp2,
    disp1         => disp1,
    disp0         => disp0
								);
motor_map         : motor generic map (phase90 => 50 us) port map(motor_cw,motor_ccw,a,b); 
   
refclk <= not refclk after Half_Period;

STIMULI : process
begin
   wait for 10 ns;
   arst <= '1', '0' after 20 ns;
   sync_rst <= '1','0' after 40 ns;
   wait for 100 ns;
   sp <= std_logic_vector(to_signed(9,8));
   force_cw <= '1';
   force_ccw <= '0';
   wait for 1 us;
   force_cw <= '0';
   force_ccw <= '1';
   wait for 1 us;
   force_cw <= '0';
   force_ccw <= '0';
   wait for 2 us;
   sp <= std_logic_vector(to_signed(3,8));
   wait;   
end process;
  
end architecture;

