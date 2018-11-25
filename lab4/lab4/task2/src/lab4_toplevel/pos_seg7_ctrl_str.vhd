library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture str of pos_seg7_ctrl is

  component pos_ctrl is
  port
    (
      rst       : in  std_logic;          -- Reset
      rst_div   : in  std_logic;          -- Reset
      mclk      : in  std_logic;          -- Clock
      mclk_div  : in  std_logic;          -- Clock to p_reg
      sync_rst  : in  std_logic;          -- Synchronous reset
      sp        : in  std_logic_vector(7 downto 0);  -- Setpoint (wanted position)
      a         : in  std_logic;          -- From position sensor
      b         : in  std_logic;          -- From position sensor
      pos       : out std_logic_vector(7 downto 0);  -- Measured Position
      force_cw  : in  std_logic;          -- Force motor clock wise motion
      force_ccw : in  std_logic;  -- Force motor counter clock wise motion
      motor_cw  : out std_logic;          -- Motor clock wise motion
      motor_ccw : out std_logic           -- Motor counter clock wise motion
    );
  end component;

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
  end component;

  component cru is
  port
    (
      arst      : in  std_logic;  -- async.reset
      refclk    : in  std_logic;  -- ref clock
      rst       : out std_logic;  -- sync arst for mclk
      rst_div   : out std_logic;  -- sync arst for mclk_div
      mclk      : out std_logic;
      mclk_div  : out std_logic   -- mclk/128
    );
  end component;

  signal mclk    : std_logic;
  signal mclk_div: std_logic;
  signal rst     : std_logic;
  signal rst_div : std_logic;

  signal pos_i  : std_logic_vector(7 downto 0);
  signal pos_d0 : std_logic_vector(3 downto 0);
  signal pos_d1 : std_logic_vector(3 downto 0);
  signal sp_i   : std_logic_vector(7 downto 0);
  signal sp_d0  : std_logic_vector(3 downto 0);
  signal sp_d1  : std_logic_vector(3 downto 0);
  signal dec    : std_logic_vector(3 downto 0);

  signal motor_cw_i : std_logic;
  signal motor_ccw_i : std_logic;

begin

  POSCTRL_0 : pos_ctrl
  port map
    (
      rst       =>   rst,
      rst_div   =>   rst_div,
      mclk      =>   mclk,
      mclk_div  =>   mclk_div,
      sync_rst  =>   sync_rst,
      sp        =>   sp_i,
      a         =>   a,
      b         =>   b,
      pos       =>   pos_i,
      force_cw  =>   force_cw,
      force_ccw =>   force_ccw,
      motor_cw  =>   motor_cw_i,    
      motor_ccw =>   motor_ccw_i
    );

  SEG7CTRL_0 : seg7ctrl
  port map
    (
      mclk          =>    mclk,
      reset         =>    rst,
      d0            =>    pos_d1,
      d1            =>    pos_d0,
      d2            =>    sp_d1,
      d3            =>    sp_d0,
      dec           =>    dec,
      abcdefgdec_n  =>    abcdefgdec_n,
      a_n           =>    a_n
    );

  CRU_0 : cru
  port map
    (
      arst       =>    arst,
      refclk     =>    refclk,
      rst        =>    rst,
      rst_div    =>    rst_div,
      mclk       =>    mclk,
      mclk_div   =>    mclk_div
    );

  sp_i <= '0' & sp(6 downto 0);
  -- dec always zeros
  dec <= (others => '0');

  -- convert sp and pos to digits
  --pos_d0 <= std_logic_vector(resize((unsigned(pos_i)/10) mod 10,4));
  --pos_d1 <= std_logic_vector(resize((unsigned(pos_i)) mod 10,4));
  --sp_d0  <= std_logic_vector(resize((unsigned(sp)/10) mod 10,4));
  --sp_d1  <= std_logic_vector(resize((unsigned(sp)) mod 10,4));
  pos_d0 <= pos_i(7 downto 4);
  pos_d1 <= pos_i(3 downto 0);
  sp_d0  <= sp_i(7 downto 4);
  sp_d1  <= sp_i(3 downto 0);
  
  motor_cw <= motor_cw_i;
  motor_ccw <= motor_ccw_i;

end architecture str;
