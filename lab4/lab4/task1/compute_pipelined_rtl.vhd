library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture rtl of compute_pipelined is

  signal addresult_i  : unsigned(17 downto 0);
  signal val_i        : std_logic;
  signal e_i          : std_logic_vector(15 downto 0);

begin

  process (rst, clk) is
    variable multresult_i : unsigned(33 downto 0);

  begin
    if rst = '1' then
      result <= (others => '0');
      max    <= '0';
      rvalid <= '0';
      addresult_i <= (others => '0');
      e_i <= (others => '0');
      val_i <= '0';

    elsif rising_edge(clk) then
      if dvalid = '1' then
        -- calculate addition
        addresult_i <= (unsigned("00" & a) + unsigned("00" & b)) +
                       (unsigned("00" & c) + unsigned("00" & d));
        -- register e for next clk
        e_i <= e;
      end if;

      if val_i = '1' then
        -- next clk calculate multiplication
        multresult_i := addresult_i * unsigned(e_i);
        -- compare logic
        if (multresult_i(33 downto 32) = "00") then
          result <= std_logic_vector(multresult_i(31 downto 0));
          max    <= '0';
        else
          result <= (others => '1');
          max    <= '1';
        end if;
      else
        result <= (others => '0');
        max    <= '0';
      end if;

      val_i <= dvalid;
      rvalid <= val_i;

    end if;
  end process;

end architecture rtl;
