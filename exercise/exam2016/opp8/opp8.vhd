library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timecalc is
  port(
    rst           : in  std_logic;
    clk_50m       : in  std_logic;
    prewash_ena   : in  std_logic;
    wash_ena      : in  std_logic;
    spin_ena      : in  std_logic;
    prewash_min   : in  std_logic_vector(7 downto 0);
    wash_min      : in  std_logic_vector(7 downto 0);
    spin_min      : in  std_logic_vector(7 downto 0);
    delay_min     : in  std_logic_vector(11 downto 0);
    completion_min: out std_logic_vector(12 downto 0)
  );
end timecalc;

architecture rtl of timecalc is

  signal sum : unsigned(12 downto 0);
  signal cnt : unsigned(1 downto 0);

begin

  P_TIMECALC : process(rst, clk_50m) is
  begin
    if rst = '1' then
      completion_min <= (others => '0');
      sum <= (others => '0');
      cnt <= (others => '0');

    elsif rising_edge(clk_50m) then

      if prewash_ena = '1' and cnt = 0 then
        sum <= sum + unsigned("00000"&prewash_min);
      end if;

      if wash_ena = '1'  and cnt = 1 then
        sum <= sum + unsigned("00000"&wash_min);
      end if;

      if spin_ena = '1' and cnt = 2 then
        sum <= sum + unsigned("00000"&spin_min);
      end if;

      if cnt = 3 then
        completion_min <= std_logic_vector(sum + unsigned('0'&delay_min));
        sum <= (others => '0');
        cnt <= (others => '0');
      end if;

      cnt <= cnt + 1;

      

    end if;
  end process;

end architecture rtl;


