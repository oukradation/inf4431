library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

entity CRU is
  port(
    rst     : in  std_logic;
    clk_20m : in  std_logic;
    clk_50m : in  std_logic;
    rst_20m : out std_logic;
    rst_50m : out std_logic
  );
end entity;

architecture rtl of CRU is

  component bufg
    port( i : in  std_logic;
          o : out std_logic );
  end component;

  signal rst_20m_s1 : std_logic;
  signal rst_50m_s1 : std_logic;
  signal rst_20m_s2 : std_logic;
  signal rst_50m_s2 : std_logic;

begin

  process ( rst, clk_20m )
  begin
    if rst = '1' then
      rst_20m_s1 <= '1';
      rst_20m_s2 <= '1';
      
    elsif rising_edge(clk_20m) then
      rst_20m_s1 <= '0';
      rst_20m_s2 <= rst_20m_s1;
    end if;
  end process;

  process ( rst, clk_50m )
  begin
    if rst = '1' then
      rst_50m_s1 <= '1';
      rst_50m_s2 <= '1';
      
    elsif rising_edge(clk_50m) then
      rst_50m_s1 <= '0';
      rst_50m_s2 <= rst_50m_s1;
    end if;
  end process;

  rst20mbufg : bufg
  port map ( i => rst_20m_s2, o => rst_20m);

  rst50mbufg : bufg
  port map ( i => rst_50m_s2, o => rst_50m);

end architecture;
