library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --unsigned, incremental operation

architecture rtl of pos_meas is
  -- states
  TYPE State_type IS (start_up_st, wait_a1_st, wait_a0_st, 
                      up_down_st, count_up_st, count_down_st);
  signal pres_state, next_state : State_type;

  -- internal signal
  signal a_int        : std_logic;
  signal b_int        : std_logic;
  signal pos_int      : signed(7 downto 0);
  signal sync_rst_i   : std_logic;
  signal a_int_br     : std_logic; -- bridge for double ff
  signal b_int_br     : std_logic; -- bridge for double ff
  signal sync_rst_i_b : std_logic; -- bridge for double ff
  signal count_up_en  : std_logic;
  signal count_down_en: std_logic;

begin
  -- syncronize asyncronous a,b from external source
  SYNC : process(clk, rst) is  
  begin
    if rst = '1' then
      a_int        <= '0';
      b_int        <= '0';
      sync_rst_i   <= '0';
      a_int_br     <= '0';
      b_int_br     <= '0';
      sync_rst_i_b <= '0';
    elsif rising_edge(clk) then
      if sync_rst_i = '1' then
        a_int        <= '0';
        b_int        <= '0';
        sync_rst_i   <= '0';
        a_int_br     <= '0';
        b_int_br     <= '0';
        sync_rst_i_b <= '0';
      else
        a_int_br     <= a;
        b_int_br     <= b;
        sync_rst_i_b <= sync_rst;
        a_int        <= a_int_br;
        b_int        <= b_int_br;
        sync_rst_i   <= sync_rst_i_b;
      end if;
    end if;
  end process SYNC;

  -- state register logic
  SEQ : process(rst, clk, sync_rst_i) is 
  begin
    if (rst = '1' or sync_rst_i = '1') then
      --reset state
      pres_state <= start_up_st;
    elsif rising_edge(clk) then
      if sync_rst_i = '1' then
        pres_state <= start_up_st;
      else
        pres_state <= next_state;
      end if;
    end if;
  end process SEQ;

  -- comb. logic
  COMB : process(a_int, b_int, pres_state) is
  begin
    count_up_en <= '0';
    count_down_en <= '0';
    case pres_state is
      when start_up_st =>
        if a_int = '1' then
          next_state <= wait_a0_st;
        else
          next_state <= wait_a1_st;
        end if;
      when wait_a0_st =>
        if a_int = '1' then
          next_state <= wait_a0_st;
        else
          next_state <= up_down_st;
        end if;
      when wait_a1_st =>
        if a_int = '1' then
          next_state <= wait_a0_st;
        else
          next_state <= wait_a1_st;
        end if;
      when up_down_st =>
        if b_int = '1' then
          next_state <= count_down_st;
        else
          next_state <= count_up_st;
        end if;
      when count_up_st =>
        count_up_en <= '1';
        next_state <= wait_a1_st;
      when count_down_st =>
        count_down_en <= '1';
        next_state <= wait_a1_st;
    end case;
  end process COMB;

  -- TODO implement this
  COUNT : process(rst, sync_rst, clk) is
  begin
    if (rst = '1') then
      -- reset pos
      pos <= (others => '0');
      pos_int <= (others => '0');
    elsif rising_edge(clk) then
      if sync_rst_i = '1' then
        -- sync reset pos
        pos <= (others => '0');
        pos_int <= (others => '0');
      else
        if count_up_en = '1' then
          pos_int <= pos_int + 1;        
          if pos_int = to_signed(127, pos_int'length) then
            pos_int <= (others => '0');
          end if;
        elsif count_down_en = '1' then
          pos_int <= pos_int - 1;
          if pos_int = to_signed(0,pos_int'length) then
            pos_int <= to_signed(127,pos_int'length);
          end if;
        end if;
        pos <= pos_int;
      end if;
    end if;
  end process COUNT;
    
end architecture rtl;
