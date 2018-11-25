library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_meas is
-- empty
end tb_pos_meas;

architecture testbench of tb_pos_meas is
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

  -- test signals
  signal rst       : std_logic;           -- Reset
  signal clk       : std_logic := '0';    -- Clock
  signal sync_rst  : std_logic;           -- Sync reset
  signal a         : std_logic;           -- From position sensor
  signal b         : std_logic;           -- From position sensor
  signal pos       : signed(7 downto 0);  -- Measured position

  signal motor_cw  : std_logic;
  signal motor_ccw : std_logic;

  constant half_period : time := 5 ns;
begin
  UUT : pos_meas
  port map 
  (
    rst      => rst,
    clk      => clk,
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

  clk <= not clk after half_period;

  -- TODO implement stimuli
  STIMULI : process
  begin
    rst <= '1', '0' after 50 ns;
    sync_rst <= '1', '0' after 50 ns;
    motor_cw <= '0';
    motor_ccw <= '1';
    wait for 20 us;
    motor_cw <= '1';
    motor_ccw <= '0';

    wait;
  end process STIMULI;

end architecture testbench;
