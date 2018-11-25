library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_seg7_ctrl is
end entity;

architecture testbench of tb_pos_seg7_ctrl is
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
    force_ccw    : in  std_logic;  -- Force motor counter clock wise motion
    motor_cw     : out std_logic;       -- Motor clock wise motion
    motor_ccw    : out std_logic;       -- Motor counter clock wise motion
    abcdefgdec_n : out std_logic_vector(7 downto 0);
    a_n          : out std_logic_vector(3 downto 0)
    );
  end component;

  component motor is
    generic ( phase90 : time );
    port 
    (
      motor_cw  : in  std_logic;
      motor_ccw : in  std_logic;
      a         : out std_logic;
      b         : out std_logic
    );
  end component;


  signal arst         :  std_logic;       -- Reset
  signal sync_rst     :  std_logic;       -- Synchronous reset 
  signal refclk       :  std_logic := '0';       -- Clock
  signal sp           :  std_logic_vector(7 downto 0);  -- Set Point
  signal a            :  std_logic;       -- From position sensor
  signal b            :  std_logic;       -- From position sensor
  signal force_cw     :  std_logic := '0';       -- Force motor clock wise motion
  signal force_ccw    :  std_logic := '0';  -- Force motor counter clock wise motion
  signal motor_cw     :  std_logic;       -- Motor clock wise motion
  signal motor_ccw    :  std_logic;       -- Motor counter clock wise motion
  signal abcdefgdec_n :  std_logic_vector(7 downto 0);
  signal a_n          :  std_logic_vector(3 downto 0);


begin
  UUT : pos_seg7_ctrl
  port map
  (
    arst         => arst          ,
    sync_rst     => sync_rst      ,
    refclk       => refclk        ,
    sp           => sp            ,
    a            => a             ,
    b            => b             ,
    force_cw     => force_cw      ,
    force_ccw    => force_ccw     ,
    motor_cw     => motor_cw      ,
    motor_ccw    => motor_ccw     ,
    abcdefgdec_n => abcdefgdec_n  ,
    a_n          => a_n             
  );

  M : motor
  generic map ( phase90 => 50 us )
  port map
  (
    motor_cw  => motor_cw,
    motor_ccw => motor_ccw,
    a         => a,
    b         => b
  );

  -- ref.clock 100MHz
  refclk <= not refclk after 10 ns;

  STIMULI : process
  begin
    report "start";
    report "set point to 50 and wait for 10 ms";
    arst <= '1', '0' after 20 ns;
    sync_rst <= '1', '0' after 20 ns;
    sp <= std_logic_vector(to_unsigned(50, sp'length));
    wait for 10 ms;
    force_ccw <= '1', '0' after 1 ms;
    wait for 2 ms;
    sp <= std_logic_vector(to_unsigned(20, sp'length));
    wait for 10 ms;
    force_cw <= '1', '0' after 1 ms;
    wait;
  end process STIMULI;

end architecture testbench;
