library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture rtl of clock is

  signal counting     : std_logic_vector(1 downto 0);
  signal sec_counter  : unsigned(27 downto 0); -- 10^8 dec = 28 bit bin
  signal sec_tic      : std_logic;
  signal sw_counter   : unsigned(15 downto 0); -- 9,999 dec = 16 bit bin
  signal tmp_cntr     : std_logic_vector(15 downto 0);

  function dec2seg( indata : unsigned(15 downto 0))
                    return std_logic_vector is
    variable seg4digit : std_logic_vector(15 downto 0);
  begin
    seg4digit(15 downto 12) := std_logic_vector(resize((indata / 1000) mod 10,4));
    seg4digit(11 downto 8)  := std_logic_vector(resize((indata / 100) mod 10,4));
    seg4digit(7 downto 4)   := std_logic_vector(resize((indata / 10) mod 10,4));
    seg4digit(3 downto 0)   := std_logic_vector(resize(indata mod 10,4));
    return seg4digit;
  end function dec2seg;

begin

  STATEMACHINE : process (mclk, reset) is
  begin

    if (reset = '1') then
      dec <= (others => '0');

      counting    <= "00";
      sw_counter  <= (others => '0');
      tmp_cntr    <= (others => '0');

    elsif rising_edge(mclk) then
      -- simple state machine
      case counting is
        -- COUNTING
        when "01"    => 
          if sec_tic = '1' then
            sw_counter <= sw_counter + 1;
          end if;

          tmp_cntr <= dec2seg(sw_counter);

          if stop = '1' then
            counting <= "00";
          end if;
          if pause = '1' then
            counting <= "10";
          end if;

        -- LAP
        when "10"   => 
          if sec_tic = '1' then
            sw_counter <= sw_counter + 1;
          end if;
          if start = '1' then
            counting <= "01";
          end if;

        -- IDLE
        when others => 
          if start = '1' then
            counting <= "01";
          end if;

      end case;
    end if;
  end process STATEMACHINE;

  d3 <= tmp_cntr(15 downto 12);
  d2 <= tmp_cntr(11 downto 8);
  d1 <= tmp_cntr(7 downto 4);
  d0 <= tmp_cntr(3 downto 0);

  SEC : process (mclk, reset) is
  begin

    if (reset = '1') then
      sec_counter <= (others => '0');

    elsif rising_edge(mclk) then
      if  sec_counter = 100000000 then -- sec_counter == 10^8 - 1
        sec_counter <= (others => '0');
      else
        sec_counter <= sec_counter + 1;
      end if;
    end if;
  end process SEC;

  sec_tic <= '1' when sec_counter = 100000000 else '0';

end architecture rtl;
