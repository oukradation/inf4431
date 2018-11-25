library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture rtl of pos_ctrl is
  component p_ctrl is
  port
  (
    rst       : in  std_logic;           -- Reset
    clk       : in  std_logic;           -- Clock
    sp        : in  signed(7 downto 0);  -- Set Point
    pos       : in  signed(7 downto 0);  -- Measured position
    motor_cw  : out std_logic;           --Motor Clock Wise direction
    motor_ccw : out std_logic            --Motor Counter Clock Wise direction
  );
  end component p_ctrl;
  component pos_meas is
  port
  (
    rst      : in  std_logic;           -- Reset
    clk      : in  std_logic;           -- Clock
    sync_rst : in  std_logic;           -- Sync reset
    a        : in  std_logic;           -- From position sensor
    b        : in  std_logic;           -- From position sensor
    pos      : out signed(7 downto 0)   -- Measured position
  );
  end component pos_meas;

  signal cw  : std_logic;
  signal ccw : std_logic;
  signal pos_int : signed(7 downto 0);


begin
  PCTRL : p_ctrl
  port map
  (
    rst       =>  rst_div   ,
    clk       =>  mclk_div  ,
    sp        =>  signed(sp),
    pos       =>  pos_int   ,
    motor_cw  =>  cw  ,
    motor_ccw =>  ccw 
  );

  POSMEAS : pos_meas
  port map
  (
    rst      => rst      ,
    clk      => mclk     ,
    sync_rst => sync_rst ,
    a        => a        ,
    b        => b        ,
    pos      => pos_int      
  );

  F1 : process (cw,ccw,force_cw, force_ccw) is
  variable sel : std_logic_vector(1 downto 0);
  begin
    sel := force_cw & force_ccw;
    if sel = "00" or sel = "11" then
      motor_cw  <= cw;
      motor_ccw <= ccw;
    elsif sel = "01" or sel = "10" then
      motor_cw  <= force_cw;
      motor_ccw <= force_ccw;
    else
      motor_cw <= '0';
      motor_ccw <= '0';
    end if;
  end process F1;

  pos <= std_logic_vector(pos_int);

  

end architecture rtl;
