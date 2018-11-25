library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compute is
  port
    (
      rst     : in  std_logic;
      clk     : in  std_logic;
      a       : in  std_logic_vector(15 downto 0);
      b       : in  std_logic_vector(15 downto 0);
      c       : in  std_logic_vector(15 downto 0);
      d       : in  std_logic_vector(15 downto 0);
      result  : out std_logic_vector(15 downto 0);
      max     : out std_logic
    );
end entity compute;

architecture pipeline_rtl of compute is
  signal ab, cd : unsigned(16 downto 0);
  signal res_i  : unsigned(17 downto 0);
begin

  process (rst, clk) is
  begin
    if rst = '1' then
      result <= (others => '0');
      res_i <= (others => '0');
      ab <= (others => '0');
      cd <= (others => '0');
      max <= '0';

    elsif rising_edge(clk) then
      ab <= unsigned('0' & a)+unsigned('0' & b);
      cd <= unsigned('0' & c)+unsigned('0' & d);

      res_i <= ('0' & ab)+('0' & cd);

      if res_i(17 downto 16) = "00" then
        max <= '0';
        result <= std_logic_vector(res_i(15 downto 0));
      else
        max <= '1';
        result <= (others => '1');
      end if;
      
    end if;
  end process;

end architecture pipeline_rtl;
