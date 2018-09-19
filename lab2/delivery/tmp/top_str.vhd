library ieee;
use ieee.std_logic_1164.all;

architecture str of top is

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

  component clock is
    port
    (
      mclk        : in  std_logic; 
      reset       : in  std_logic;
      stop        : in  std_logic;
      start       : in  std_logic;
      pause       : in  std_logic;
      d0          : out std_logic_vector(3 downto 0);
      d1          : out std_logic_vector(3 downto 0);
      d2          : out std_logic_vector(3 downto 0);
      d3          : out std_logic_vector(3 downto 0);
      dec         : out std_logic_vector(3 downto 0)
    );
  end component clock;

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
  sec_clk:clock  port map(
                       mclk  => mclk , 
                       reset => reset, 
                       stop  => stop , 
                       start => start, 
                       pause => pause,
                       d0    => d0   , 
                       d1    => d1   , 
                       d2    => d2   , 
                       d3    => d3   , 
                       dec   => dec 
                     );
end architecture str;
