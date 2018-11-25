library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture beh of p_ctrl is
type state_type is (idle,sampel,motor); --ny datatype, tilstander i forløp
signal NS,PS : state_type; -- interne signal av typen state_type


signal sp_int          : signed(7 downto 0);
signal pos_int         : signed(7 downto 0);
signal q_sp            : signed(7 downto 0);
signal q_pos           : signed(7 downto 0);
signal err_reg,err     : signed(7 downto 0) := (others => '0');
signal motor_cw_reg,motor_cw_next    : std_logic;  
signal motor_ccw_reg,motor_ccw_next   : std_logic; 
 
begin
   -- tilordning av interne signal til output
   motor_cw <= motor_cw_reg;
   motor_ccw <= motor_ccw_reg;
   
   sync_proc : process(rst_div,mclk_div) -- egen klokke/rst, ikke master
   begin
     
     if rst_div = '1' then
	    PS <= idle;
	    sp_int <=  (others => '0');
	    pos_int <= (others => '0');
        motor_cw_reg <= '0';
	    motor_ccw_reg <= '0';
	 elsif rising_edge(mclk_div) then
	    PS <= NS;
		-- dobbel flopping
		q_sp <= sp;
		sp_int <= q_sp;
		q_pos <= pos;
		pos_int <= q_pos;
		-- tilordning av interne signaler for tilbakekobling, oppdatering av registre
		err_reg <= err;
        motor_cw_reg <= motor_cw_next ;
		motor_ccw_reg <= motor_ccw_next;

     end if;
end process;

   comb_proc :process(PS,motor_ccw_reg,motor_cw_reg,err_reg)
   begin
      motor_cw_next <= '0';
      motor_ccw_next <= '0';
	  err <= err_reg; -- leser fra register, mm den er i sample state
      case PS is
      when idle =>
         NS <= sampel;
	  when sampel =>
	      -- tilbakekoblingssløyfe
		 err <= sp_int - pos_int; -- beregning av avvik fra setpunkt på regulator
		 NS <= motor;
		 motor_ccw_next <= motor_ccw_reg;
		 motor_cw_next <= motor_cw_reg;
      when motor => -- motorretning gis signal ut i fra avvik 
	     if err_reg > 0 then
		    motor_cw_next <= '1';
			motor_ccw_next <= '0';
		 elsif err_reg < 0 then 
		    motor_cw_next <= '0';
			motor_ccw_next <= '1';
		 else
            motor_cw_next <= '0';
            motor_ccw_next <= '0';			
	  	 end if;   
		 NS <= sampel; -- tilbake til beregning
         end case;
       end process;		 
end architecture;		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 