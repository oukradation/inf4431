library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delaytimecalc is
  port
    (
      rst       : in  std_logic;
      clk_20m   : in  std_logic;
      delay     : in  std_logic;
      delay_val : out std_logic;
      delay_min : out std_logic_vector(11 downto 0)
    );
end entity delaytimecalc;

architecture rtl of delaytimecalc is

  signal delay_dl         : std_logic;
  signal delayfalling_str : std_logic;
  signal cnt              : unsigned(11 downto 0);

begin

  P_CNTSTART: process(rst, clk_20m) is
  begin
    if rst = '1' then
      delay_dl    <= '0';
      delayfalling_str <= '0';
    elsif rising_edge(clk_20m) then
      -- 
      if (delay_dl = '1') and (delay = '0') then
        delayfalling_str  <= '1';
      else 
        delayfalling_str  <= '0';
      end if;
      --
      delay_dl <= delay;
    end if;
  end process P_CNTSTART;

  P_DELAYCNT: process (rst, clk_20m) is
  begin

    if rst = '1' then
      cnt       <= (others => '0');
      delay_val <= '0';
      delay_min <= (others => '0');

    elsif rising_edge(clk_20m) then
      if delay = '1' then
        cnt <= cnt + 1;
        if cnt > x"5A0" then -- possible comparison? yes
          cnt <= x"5A0";
        end if;
      end if;

      if delayfalling_str = '1' then
        delay_min <= std_logic_vector(cnt);
        cnt <= ( others => '0' );
        delay_val <= '1';
      else
        delay_val <= '0';
      end if;
    end if;
  end process P_DELAYCNT;

end architecture rtl;
