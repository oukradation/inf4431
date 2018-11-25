library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_p_ctrl is
end entity;

architecture tb of tb_p_ctrl is
   component p_ctrl is
      port(
	       rst        : in std_logic;
		   clk        : in std_logic;
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

  
component motor is
       generic
	          (
	          phase90 : time := 50 ns
	           );
       port (
         motor_cw  : in  std_logic;
         motor_ccw : in  std_logic;
         a         : out std_logic;
         b         : out std_logic
             ); 
end component;

signal rst        : std_logic;
signal clk        : std_logic := '0';
signal sp         : signed(7 downto 0);
signal pos        : signed(7 downto 0);
signal motor_cw   : std_logic;
signal motor_ccw  : std_logic;
signal sync_rst   : std_logic;           -- Sync reset, eksternt signal, asynkront
signal a          : std_logic;           -- From position sensor, eksternt signal, asynkront
signal b          : std_logic;           -- From position sensor, eksternt signal, asynkront


constant Half_Period : time := 10 ns; -- 50 Mhz klokkefrekvens 

begin

port_pctrl: p_ctrl port map(rst,clk,sp,pos,motor_cw,motor_ccw);
port_posmeas: pos_meas port map(rst,clk,sync_rst,a,b,pos);
port_motor: motor generic map(phase90 => 50 ns) port map(motor_cw,motor_ccw,a,b); 

clk <= not clk after Half_Period;

STIMULI : process
begin

wait for 10 ns;
rst <= '1','0' after 20 ns;
sync_rst <= '1','0' after 40 ns;
sp <= to_signed(0,sp'length); -- 
wait for 100 ns;
sp <= to_signed(10,sp'length);
wait for 2200 ns;
sp <= to_signed(0,sp'length);
wait;

end process;
end architecture;







