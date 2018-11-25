library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fibonacci is
  generic
    (
      FIBWIDTH : natural := 32
    );
  port
    (
      rst     : in  std_logic;
      clk     : in  std_logic;
      run     : in  std_logic;
      funcsel : in  std_logic_vector(2 downto 0);
      nmax    : in  std_logic_vector(7 downto 0);
      inum    : out std_logic_vector(7 downto 0);
      rdy     : out std_logic;
      fn      : out std_logic_vector(FIBWIDTH-1 downto 0)
    );
end entity fibonacci;

architecture rtl of fibonacci is

  signal f0, f0_n : unsigned(FIBWIDTH-1 downto 0);
  signal f1, f1_n : unsigned(FIBWIDTH-1 downto 0);
  signal f2, f2_n : unsigned(FIBWIDTH-1 downto 0);
  signal n,  n_n  : unsigned(7 downto 0);

  type f_state is (IDLE_ST, CALC_ST, FN_ST, F1_ST, F0_ST, UPDATE_ST, RDY_ST);
  signal st, st_n : f_state;

begin

  STATE_REG : process(rst, clk) is
  begin
    -- which signal should be reset?
    if rst = '1' then
      st   <= IDLE_ST;
      f1   <= (others => '0');
      f0   <= (others => '0');
      f2   <= (others => '0');
      n    <= (others => '0');
    elsif rising_edge(clk) then
      st <= st_n;
      f1 <= f1_n;
      f2 <= f2_n;
      f0 <= f0_n;
      n  <= n_n;
    end if;
  end process STATE_REG;

  -- which signal is needed for the sensitivity list?
  -- input to conditions
  -- states
  -- internal signals that are being changed?
  -- outputs??
  STATE_COMB : process(run, funcsel, n, nmax, f0, f1, f2, st) is
  begin
    -- default values?
    rdy <= '0';

    case st is
      when IDLE_ST =>
        f0_n <= (others => '0');
        f1_n <= (others => '0');
        f2_n <= (others => '0');
        n_n  <= (others => '0');
        if run = '1' then
          if funcsel = "001" then
            st_n <= CALC_ST;
          end if;
        end if;

      when CALC_ST =>
        if n >= 2 then
          st_n <= FN_ST;
        else
          if n = 1 then
            st_n <= F1_ST;
          else
            st_n <= F0_ST;
          end if;
        end if;

      when FN_ST =>
        f2_n <= f1+f0;
        st_n <= UPDATE_ST;
        
      when F0_ST =>
        f2_n <= (others => '0');
        st_n <= UPDATE_ST;
        
      when F1_ST =>
        f2_n <= to_unsigned(1,FIBWIDTH);
        st_n <= UPDATE_ST;

      when UPDATE_ST =>
        f0_n <= f1;
        f1_n <= f2;
        if n = unsigned(nmax) then
          st_n <= IDLE_ST;
        else
          st_n <= RDY_ST;
        end if;

      when RDY_ST =>
        n_n <= n+1;
        rdy <= '1';
        st_n <= CALC_ST;
    end case;
  end process STATE_COMB;



  inum <= std_logic_vector(n);
  fn   <= std_logic_vector(f2);

end architecture rtl;
