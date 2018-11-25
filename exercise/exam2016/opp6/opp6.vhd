library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- this module should syncronize delay_val with
-- 2 register and set delay_time like delay_min
-- when delay signal changes from low to high
-- and delay_ena is 1
-- when delay_ena is 0 then delay time = 0

entity sync is
  port
    (
      rst       : in  std_logic;
      clk_50m   : in  std_logic;
      delay_ena : in  std_logic;
      delay_val : in  std_logic;
      delay_min : in  std_logic_vector(11 downto 0);
      delay_time: out std_logic_vector(11 downto 0)
    );
end entity sync;

architecture rtl of sync is
  signal delay_val_s1 : std_logic;
  signal delay_val_s2 : std_logic;
  signal delay_val_dl : std_logic;

begin

  P_SYNCH: process (rst, clk_50m) is
  begin
    if rst = '1' then
      delay_val_s1 <= '0';
      delay_val_s2 <= '0';
      delay_val_dl <= '0';
    elsif rising_edge(clk_50m) then
      delay_val_s1 <= delay_val;
      delay_val_s2 <= delay_val_s1;
      delay_val_dl <= delay_val_s2;

      if delay_ena = '1' and (delay_val_dl = '0' and delay_val_s2 = '1') then
        delay_time <= delay_min;
      elsif delay_ena = '0' then
        delay_time <= (others => '0');
      end if;
      

    end if;
  end process;
end architecture rtl;

