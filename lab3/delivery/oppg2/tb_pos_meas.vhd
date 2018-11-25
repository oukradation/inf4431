library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pos_meas is
end entity;

architecture tb of tb_pos_meas is
   component pos_meas is
      port(-- System Clock and Reset
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
	          phase90 : time := 50 us
	           );
       port (
         motor_cw  : in  std_logic;
         motor_ccw : in  std_logic;
         a         : out std_logic;
         b         : out std_logic
             ); 
   end component;
   
   
   signal motor_cw : std_logic := '0';
   signal motor_ccw: std_logic := '0';   
   signal rst      : std_logic := '0';
   signal clk      : std_logic := '0';
   signal sync_rst : std_logic := '0';
   signal a        : std_logic := '0';
   signal b        : std_logic := '0';
   signal pos      : signed(7 downto 0) := (others => '0');		  
   constant Half_Period : time := 10 ns; -- 50 Mhz klokkefrekvens
   

begin
   
 pos_test:  pos_meas  port map(rst,clk,sync_rst,a,b,pos);
 motor_tb:  motor generic map(phase90 => 100 ns) port map(motor_cw,motor_ccw,a,b);  
 clk <= not clk after Half_Period;
   
   STIMULI: process
   begin
   wait for 10 ns;
   rst <= '1', '0' after 20 ns;
   sync_rst <= '1', '0' after 40 ns;
   wait for 100 ns;
   motor_cw <= '1';
   motor_ccw <= '0';
   wait for 1 us;
   motor_cw <= '0';
   motor_ccw <= '1';
   wait;
   end process;
end tb;

