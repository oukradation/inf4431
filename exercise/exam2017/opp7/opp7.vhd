library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
  port
    (
      rst   : in  std_logic;
      clk   : in  std_logic;
      load  : in  std_logic;
      seed  : in  std_logic_vector(2 downto 0);
      run   : in  std_logic;
      q     : out std_logic_vector(2 downto 0);
      err   : out std_logic
    );
end entity lfsr;

architecture rtl of lfsr is
  
  signal q_reg : std_logic_vector(2 downto 0);

begin

  process(rst, clk) is
  begin
    if rst='1' then
      q_reg <= "000";
      err <= '0';
    elsif rising_edge(clk) then
      if (run = '1') then
        q_reg(2) <= q_reg(0) XOR q_reg(1);
        q_reg(1) <= q_reg(2);
        q_reg(0) <= q_reg(1);
      end if;
      
      if load = '1' then
        if seed = "000" then
          err <= '1';
        else
          err <= '0';
          q_reg <= seed;
        end if;
      end if;
    end if;
  end process;

  q <= q_reg;

end architecture rtl;

