library IEEE;
use IEEE.std_logic_1164.all;

entity SHIFT8 is
  port
  (
    RST_N     :   IN  STD_LOGIC;
    CLK       :   IN  STD_LOGIC;
    DIN       :   IN  STD_LOGIC;
    DOUT      :   OUT STD_LOGIC_VECTOR(7 downto 0)
  );
end SHIFT8;

architecture netlist of SHIFT8 is
  component dff
    port
    (
      rst_n     : in  std_logic;   -- Reset
      mclk      : in  std_logic;   -- Clock
      din       : in  std_logic;   -- Data in
      dout      : out std_logic    -- Data out
    );
  end component;

  -- internal signals
  signal dout_temp : std_logic_vector(7 downto 1);
  
begin
  dff1 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>DIN,           DOUT=>dout_temp(7));
  dff2 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(7),  DOUT=>dout_temp(6));
  dff3 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(6),  DOUT=>dout_temp(5));
  dff4 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(5),  DOUT=>dout_temp(4));
  dff5 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(4),  DOUT=>dout_temp(3));
  dff6 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(3),  DOUT=>dout_temp(2));
  dff7 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(2),  DOUT=>dout_temp(1));
  dff8 : DFF port map(RST_N=>RST_N, MCLK=>CLK, DIN=>dout_temp(1),  DOUT=>DOUT(0));
  
  DOUT(7 downto 1) <= dout_temp;

end netlist;
