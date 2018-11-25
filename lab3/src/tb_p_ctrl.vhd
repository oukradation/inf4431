library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_p_ctrl is
-- empty
end tb_p_ctrl;

architecture testbench of tb_p_ctrl is
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

  -- test signals
  signal rst       : std_logic;           -- Reset
  signal mclk      : std_logic := '0';    -- Master Clock
  signal sclk      : std_logic := '0';    -- Slave Clock
  signal sync_rst  : std_logic;           -- Sync reset
  signal a         : std_logic;           -- From position sensor
  signal b         : std_logic;           -- From position sensor
  signal pos       : signed(7 downto 0);  -- Measured position

  signal motor_cw  : std_logic;
  signal motor_ccw : std_logic;

  signal sp        : signed(7 downto 0);

  constant master_period : time := 5 ns;
  constant slave_period : time := 13 ns;
begin
  UUT : pos_meas
  port map 
  (
    rst      => rst,
    clk      => mclk,
    sync_rst => sync_rst,
    a        => a,
    b        => b,
    pos      => pos
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

  CTRL : p_ctrl
  port map
  (
    rst       =>  rst,
    clk       =>  sclk,
    sp        =>  sp,
    pos       =>  pos,
    motor_cw  =>  motor_cw,
    motor_ccw =>  motor_ccw 
  );

  -- Two clock process
  mclk <= not mclk after master_period;
  sclk <= not sclk after slave_period;

  -- TODO implement stimuli
  STIMULI : process
  begin
    report "start";
    rst <= '1', '0' after 50 ns;
    sync_rst <= '1', '0' after 50 ns;
    -- set position to 13 and observe from waveform
    sp <= to_signed(13, sp'length);
    wait for 100 us;
    -- set position to 0 and observe from waveform
    sp <= to_signed(0, sp'length);
    wait;
  end process STIMULI;

end architecture testbench;
