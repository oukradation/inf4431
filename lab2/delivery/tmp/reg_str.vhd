library ieee;
use ieee.std_logic_1164.all;

architecture str of reg is

  component seg7ctrl is
    port
    (
      mclk          : in  std_logic;      -- 100MHz, posedge
      reset         : in  std_logic;      -- Asyncronous, active high
      d0            : in  std_logic_vector(3 downto 0);
      d1            : in  std_logic_vector(3 downto 0);
      d2            : in  std_logic_vector(3 downto 0);
      d3            : in  std_logic_vector(3 downto 0);
      dec           : in  std_logic_vector(3 downto 0);
      abcdefgdec_n  : out std_logic_vector(7 downto 0);
      a_n           : out std_logic_vector(3 downto 0)
    );
  end component seg7ctrl;

  component regctrl is
    port
    (
      mclk        : in  std_logic; 
      reset       : in  std_logic;
      load        : in  std_logic;
      di          : in  std_logic_vector(3 downto 0);
      sel         : in  std_logic_vector(1 downto 0);
      d0          : out std_logic_vector(3 downto 0);
      d1          : out std_logic_vector(3 downto 0);
      d2          : out std_logic_vector(3 downto 0);
      d3          : out std_logic_vector(3 downto 0);
      dec         : out std_logic_vector(3 downto 0)
    );
  end component regctrl;

  signal d0,d1,d2,d3,dec : std_logic_vector(3 downto 0);

begin
  seg:seg7ctrl port map(
                       mclk         => mclk,
                       reset        => reset,
                       d0           => d0, 
                       d1           => d1,
                       d2           => d2,
                       d3           => d3,
                       dec          => dec,
                       abcdefgdec_n => abcdefgdec_n,
                       a_n          => a_n
                     );
  reg:regctrl  port map(
                       mclk  => mclk , 
                       reset => reset, 
                       load  => load , 
                       di    => di   , 
                       sel   => sel  , 
                       d0    => d0   , 
                       d1    => d1   , 
                       d2    => d2   , 
                       d3    => d3   , 
                       dec   => dec 
                     );
end architecture str;
