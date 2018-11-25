package body subprog_pkg is
  -- inverting
  function parity(indata : std_logic_vector(15 downto 0)) 
           return std_logic is
    -- internal variable
    variable par_i : std_logic := '0';
  begin
    for i in indata'range loop
      if indata(i) = '1' then
        par_i := not par_i;
      end if;
    end loop;
    return par_i;
  end parity;

  -- xor overload with input as unsigned type
  function parity(indata : unsigned(15 downto 0)) 
           return std_logic is
    -- internal variable
    variable par_i : std_logic := '0';
  begin
    for i in indata'range loop
      par_i := par_i xor indata(i);
    end loop;
    return par_i;
  end parity;

  ---- procedure definition
  -- inverting
  procedure parity(indata : in std_logic_vector(15 downto 0);
                   par    : out std_logic) is
  -- internal variable
  variable par_i : std_logic := '0';
  
  begin
    for i in indata'range loop
      if indata(i) = '1' then
        par_i := not par_i;
      end if;
    end loop;
    par := par_i;
  end parity;

  -- xor overload with input as unsigned type
  procedure parity(indata : in unsigned(15 downto 0);
                   par    : out std_logic) is
  -- internal variable
  variable par_i : std_logic := '0';
  
  begin
    for i in indata'range loop
      par_i := par_i xor indata(i);
    end loop;
    par := par_i;
  end parity;

  -- hex2seg7
  function hex2seg7(indata : std_logic_vector(3 downto 0);
                    dec    : std_logic)
                    return std_logic_vector is
    variable outdata : std_logic_vector(7 downto 1) := (others => '0');
  begin
    case indata is
      when "0000" => outdata := "0000001";
      when "0001" => outdata := "1001111";
      when "0010" => outdata := "0010010";
      when "0011" => outdata := "0000110";
      when "0100" => outdata := "1001100";
      when "0101" => outdata := "0100100";
      when "0110" => outdata := "0100000";
      when "0111" => outdata := "0001111";
      when "1000" => outdata := "0000000";
      when "1001" => outdata := "0001100";
      when "1010" => outdata := "0001000";
      when "1011" => outdata := "1100000";
      when "1100" => outdata := "0110001";
      when "1101" => outdata := "1000010";
      when "1110" => outdata := "0110000";
      when "1111" => outdata := "0111000";
      when others => outdata := "UUUUUUU";
    end case;
    return outdata & not dec;
  end hex2seg7;
end package body subprog_pkg;
