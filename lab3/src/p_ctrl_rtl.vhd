library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture rtl of p_ctrl is
  TYPE State_type IS (idle_st, sample_st, motor_st);
  signal pres_state, next_state : State_type;

  signal err     : signed(7 downto 0);
  signal sp_br   : signed(7 downto 0);
  signal pos_br  : signed(7 downto 0);
  signal sp_int  : signed(7 downto 0);
  signal pos_int : signed(7 downto 0);
  signal cw_en   : std_logic;
  signal ccw_en  : std_logic;
  signal err_en  : std_logic;

begin
  -- syncronisation
  SYNC : process(rst, clk) is
  begin
    if rst = '1' then
      sp_br   <= (others => '0'); 
      pos_br  <= (others => '0');
      sp_int  <= (others => '0');
      pos_int <= (others => '0');
      motor_cw  <= '0';
      motor_ccw <= '0';
    elsif rising_edge(clk) then
      sp_br   <= sp; 
      pos_br  <= pos;
      sp_int  <= sp_br;
      pos_int <= pos_br;
      if ( cw_en  and ccw_en ) = '1' then
        motor_cw  <= '0';
        motor_ccw <= '0';
      elsif cw_en = '1'  then
        motor_cw  <= '1';
        motor_ccw <= '0';
      elsif  ccw_en = '1' then
        motor_cw  <= '0';
        motor_ccw <= '1';
      end if;
      if err_en = '1' then
        err <= sp_int - pos_int;
      end if;
    end if;
  end process SYNC;

  -- state logic register
  SEQ : process(rst, clk) is
  begin
    if rst = '1' then
      pres_state <= idle_st;
    elsif rising_edge(clk) then
      pres_state <= next_state;
    end if;
  end process SEQ;

  -- comb logic
  COMB : process(pres_state, err,sp_int, pos_int) is
  begin
    cw_en  <= '0';
    ccw_en <= '0';
    err_en <= '0';
    case pres_state is
      when idle_st =>
        next_state <= sample_st;
      when sample_st =>
        err_en <= '1';
       
        next_state <= motor_st;
      when motor_st =>
        if err > 0 then
          cw_en  <= '1';
        elsif err < 0 then
          ccw_en <= '1';
        else
          cw_en <= '1';
          ccw_en <= '1';
        end if;
        next_state <= sample_st;
    end case;
  end process COMB;

end architecture rtl;
