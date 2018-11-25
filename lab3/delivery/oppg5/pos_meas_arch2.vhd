library ieee;
use ieee.std_logic_1164.all;


architecture pos_meas_beh of pos_meas is
   type state_type is (start_up,wait_a1,wait_a0,up_down,count_up,count_down);
   signal NS,PS : state_type;
   
   signal sync_rst_int                          : std_logic  := '0';
   signal q_synq_rst                            : std_logic  := '0';
   signal a_int                                 : std_logic := '0';
   signal b_int                                 : std_logic := '0';
   signal q_a                                   : std_logic := '0';
   signal q_b                                   : std_logic := '0';
   signal count_up_en,count_down_en             : std_logic := '0';
   signal pos_int                               : signed(7 downto 0) := (others => '0');
begin
   sync_proc : process(rst,clk) 
   begin
      if rst = '1' then
         PS <= start_up;
		 a_int <= '0';
		 b_int <= '0';
		 pos_int <= (others => '0');
      elsif rising_edge(clk) then
         PS <= NS;
		   if sync_rst_int = '1' then  
		      PS <= start_up;
		      a_int <= '0';
		      b_int <= '0';
			  pos_int <= (others => '0');
		   end if;
		   q_a <= a;
		   a_int <= q_a;
		   q_b <= b;
		   b_int <= q_b;
		   q_synq_rst <= rst;
	       sync_rst_int <= q_synq_rst;
		   
		   if count_up_en = '1' then
		      pos_int <= pos_int + 1;
		   end if;
		   if count_down_en = '1' then
		      pos_int <= pos_int - 1;
		   end if;
		   pos <= pos_int;
	  end if;	 
   end process;

   comb_proc :process(PS,a_int,b_int,pos_int)
   begin
      count_up_en <= '0';
      count_down_en <= '0';
      case PS is
      when start_up =>
         if a_int = '1' then
		    NS <= wait_a0;
	     else
		    NS <= wait_a1;
	     end if;	   
      when wait_a1 =>
         if a_int = '1' then
	        NS <= wait_a0; 
	     else 
	        NS <= wait_a1;
	     end if;
      when wait_a0 =>
         if a_int = '0' then
	        NS <= up_down;
	     else
            NS <= wait_a0;
         end if;		 
      when up_down =>
	     if b_int = '1' then
            NS <= count_down;
         else 
	        NS <= count_up;
         end if;	  
      when count_up =>
	     if pos_int < 127 then
		    count_up_en <= '1';
		 end if;
         NS <= wait_a1;
      when count_down =>
         if pos_int > 0 then
		    count_down_en <= '1';
	     end if;
		 NS <= wait_a1;
      end case;
   end process;
end architecture;

