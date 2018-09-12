library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.subprog_pkg.all;

entity tb_hex2seg7 is
  --empty
end tb_hex2seg7;

architecture beh of tb_hex2seg7 is
  component seg7model is
    port (
      a_n           : in  std_logic_vector(3 downto 0);
      abcdefgdec_n  : in  std_logic_vector(7 downto 0);
      disp3         : out std_logic_vector(3 downto 0);
      disp2         : out std_logic_vector(3 downto 0);
      disp1         : out std_logic_vector(3 downto 0);
      disp0         : out std_logic_vector(3 downto 0)
    );
  end component seg7model;
  signal a_n           : std_logic_vector(3 downto 0);
  signal abcdefgdec_n  : std_logic_vector(7 downto 0);
  signal disp3         : std_logic_vector(3 downto 0);
  signal disp2         : std_logic_vector(3 downto 0);
  signal disp1         : std_logic_vector(3 downto 0);
  signal disp0         : std_logic_vector(3 downto 0);

  signal indata        : std_logic_vector(3 downto 0);
  signal dec           : std_logic;

begin
  UUT : seg7model
  port map 
  (
    a_n          => a_n,         
    abcdefgdec_n => abcdefgdec_n,
    disp3        => disp3,       
    disp2        => disp2,       
    disp1        => disp1,       
    disp0        => disp0       
  );
  
  STIMULI: process
  begin
    a_n <= "1110";
    dec <= '1';
    abcdefgdec_n <= (others =>'0');
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0000",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0001",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0010",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0011",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0100",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0101",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0110",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("0111",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1000",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1001",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1010",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1011",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1100",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1101",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1110",dec);
    wait for 50 ns;
    abcdefgdec_n <= hex2seg7("1111",dec);
    wait;
  end process STIMULI;

end beh;
