library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SHIFT32 is
    port
    (
        RST_N   : IN STD_LOGIC;     -- reset
        CLK     : IN STD_LOGIC;     -- clock
        DIN     : IN STD_LOGIC;     -- Data in
        DOUT    : OUT STD_LOGIC_VECTOR(31 downto 0)     -- Data out
    );
end SHIFT32;


architecture netlist of SHIFT32 is
    component DFF
        port
        (
            rst_n     : in  std_logic;   -- Reset
            mclk      : in  std_logic;   -- Clock
            din       : in  std_logic;   -- Data in
            dout      : out std_logic    -- Data out
        );
    end component;
    signal dout_temp : STD_LOGIC_VECTOR(31 downto 0);
begin
    arr : for i in 1 to 31 generate
        arrx : DFF port map(RST_N, CLK, dout_temp(i), dout_temp(i-1));
    end generate arr;
    arr0 : DFF port map(RST_N, CLK, DIN, dout_temp(31));
    DOUT <= dout_temp;

end netlist;
