library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_ctrl is
-- empty
end tb_pos_ctrl;

architecture testbench of tb_pos_ctrl is
  component pos_ctrl is
  port 
  (
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
  end component pos_ctrl;
  component motor is
    generic ( phase90 : time );
    port 
    (
      motor_cw  : in  std_logic;
      motor_ccw : in  std_logic;
      a         : out std_logic;
      b         : out std_logic
    );
  end component motor;

  -- test signals
  signal rst       : std_logic;           -- Reset
  signal rst_div   : std_logic;           -- Reset
  signal mclk      : std_logic := '0';    -- Master Clock
  signal mclk_div  : std_logic := '0';    -- Slave Clock
  signal sync_rst  : std_logic;           -- Sync reset
  signal a         : std_logic;           -- From position sensor
  signal b         : std_logic;           -- From position sensor
  signal pos       : std_logic_vector(7 downto 0);

  signal motor_cw  : std_logic;
  signal motor_ccw : std_logic;
  signal force_cw  : std_logic := '0';
  signal force_ccw : std_logic := '0';

  signal sp        : std_logic_vector(7 downto 0);

  constant master_period : time := 5 ns;
  constant slave_period : time := 10 ns;

begin
  UUT : pos_ctrl
  port map
  (
    rst       =>  rst      , 
    rst_div   =>  rst_div  , 
    mclk      =>  mclk     , 
    mclk_div  =>  mclk_div , 
    sync_rst  =>  sync_rst , 
    sp        =>  sp       , 
    a         =>  a        , 
    b         =>  b        , 
    pos       =>  pos      , 
    force_cw  =>  force_cw , 
    force_ccw =>  force_ccw, 
    motor_cw  =>  motor_cw , 
    motor_ccw =>  motor_ccw   
  );

  M : motor
  generic map ( phase90 => 1 us )
  port map
  (
    motor_cw  => motor_cw,
    motor_ccw => motor_ccw,
    a         => a,
    b         => b
  );

  -- Two clock process
  mclk <= not mclk after master_period;
  mclk_div <= not mclk_div after slave_period;

  -- TODO implement stimuli
  STIMULI : process
  begin
    report "start";
    rst <= '1', '0' after 50 ns;
    rst_div <= '1', '0' after 50 ns;
    sync_rst <= '1', '0' after 50 ns;
    -- set position to 13 and observe from waveform
    sp <= std_logic_vector(to_signed(13, sp'length));
    wait for 100 us;
    -- set position to 0 and observe from waveform
    sp <= std_logic_vector(to_signed(127, sp'length));
    wait for 100 us;
    force_ccw <= '1', '0' after 100 us;
    wait;
  end process STIMULI;

end architecture testbench;
