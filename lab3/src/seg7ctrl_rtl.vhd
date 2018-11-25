library ieee;
use ieee.std_logic_1164.all;
use work.subprog_pkg.all;

architecture rtl of seg7ctrl is
  component timer is
    generic ( n : integer );  
    port
      (
       MCLK      : in std_logic;      -- klokkesignal fra pushbutton
       RESET     : in std_logic;      -- asynkron reset
       COUNT     : out std_logic_vector(n-1 downto 0) -- telleverdi
      );
  end component timer;

  component decoder is
    port
    (
      MCLK        : in  std_logic;
      RESET       : in  std_logic;
      INP         : in  std_logic_vector(1 downto 0); -- input 
      OUTP        : out std_logic_vector(3 downto 0)  -- output
    );
  end component decoder;

  -- constant
  constant nbit : integer := 16;

  -- internal signal
  signal count_i : std_logic_vector(nbit-1 downto 0);


begin

  counter : timer generic map ( n => nbit)
                  port map
                  (
                    mclk  => mclk,
                    reset => reset,
                    count => count_i
                  );
  dec2to4 : decoder port map
                    (
                      mclk  => mclk,
                      reset => reset,
                      inp   => count_i(nbit-1 downto nbit-2),
                      outp  => a_n
                    );
  
  process (mclk, reset) is

  begin

    if (reset = '1') then
      abcdefgdec_n  <= (others => '0');

    elsif rising_edge(mclk) then

      case count_i(nbit-1 downto nbit-2) is
        when "00"   => abcdefgdec_n <= hex2seg7(d0,dec(0));
        when "01"   => abcdefgdec_n <= hex2seg7(d1,dec(1));
        when "10"   => abcdefgdec_n <= hex2seg7(d2,dec(2));
        when others => abcdefgdec_n <= hex2seg7(d3,dec(3));
      end case;

    end if;

  end process;

end architecture rtl;
