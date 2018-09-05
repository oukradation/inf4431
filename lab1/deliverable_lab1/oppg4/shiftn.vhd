library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SHIFTN is
    generic ( N : integer );
    port
    (
        RST_N   : IN STD_LOGIC;     -- reset
        CLK     : IN STD_LOGIC;     -- clock
        DIN     : IN STD_LOGIC;     -- Data in
        DOUT    : OUT STD_LOGIC_VECTOR(N-1 downto 0)     -- Data out
    );
end SHIFTN;


architecture netlist of SHIFTN is
    component DFF
        port
        (
            rst_n     : in  std_logic;   -- Reset
            mclk      : in  std_logic;   -- Clock
            din       : in  std_logic;   -- Data in
            dout      : out std_logic    -- Data out
        );
    end component;

    -- internal signal
    signal dout_temp : STD_LOGIC_VECTOR(N-1 downto 0);

begin
    -- connect second to last ff
    arr : for i in 1 to N-1 generate
        arrx : DFF port map(RST_N, CLK, dout_temp(i), dout_temp(i-1));
    end generate arr;

    -- first ff
    arr0 : DFF port map(RST_N, CLK, DIN, dout_temp(N-1));

    -- update output
    DOUT <= dout_temp;

end netlist;
