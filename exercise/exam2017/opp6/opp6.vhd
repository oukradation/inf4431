library ieee;
use ieee.std_logic_1164.all;

entity seq_gen is
  port
    (
      rst   : in  std_logic;
      clk   : in  std_logic;
      run   : in  std_logic;
      q     : out std_logic_vector(2 downto 0)
    );
end entity seq_gen;

-- moore FSM
-- q seq : 4 2 5 6 7 3 1

architecture rtl of seq_gen is

  type state is ('4','2','5','6','7','3','1',IDLE);
  signal st, st_next : state;

begin

  state_reg : process(rst,clk) is
  begin
    if (rst='1') then
      st <= IDLE;
    elsif rising_edge(clk) then
      st <= st_next; 
    end if;
  end process state_reg;

  state_comb : process(st,run) is
  begin
    case st is
      when IDLE =>
        st_next <= '4';
      when '4' =>
        q <= "100";
        if run='1' then
          st_next <= '2';
        end if;
      when '2' =>
        q <= "010";
        if run='1' then
          st_next <= '5';
        end if;
      when '5' =>
        q <= "101";
        if run='1' then
          st_next <= '6';
        end if;
      when '6' =>
        q <= "110";
        if run='1' then
          st_next <= '7';
        end if;
      when '7' =>
        q <= "111";
        if run='1' then
          st_next <= '3';
        end if;
      when '3' =>
        q <= "011";
        if run='1' then
          st_next <= '1';
        end if;
      when '1' =>
        q <= "001";
        if run='1' then
          st_next <= '4';
        end if;
      end case;
  end process state_comb;

end architecture rtl;
