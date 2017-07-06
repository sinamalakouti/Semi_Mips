library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Flags is
  port (
    Cin , CSet , CReset , CLoad , clk : IN std_logic;
    Cout : OUT std_logic;
    Zin , ZSet , ZReset , ZLoad : IN std_logic;
    Zout : OUT std_logic
  ) ;
end entity ; -- Flags

architecture dataflow of Flags is

signal  cBetween : std_logic := '0';
signal  zBetween : std_logic := '0'; 

begin
              
  cBetween <= '0' when CReset = '1' else
              '1' when CSet = '1' else
              Cin when CLoad= '1' else
              cBetween;

  zBetween <= '0' when ZReset = '1' else
              '1' when ZSet = '1' else
              Zin when ZLoad= '1' else
              zBetween;

  flagsPro : process( clk )
  begin

    if clk = '1' and clk'event then
      Cout <= cBetween;
      Zout <= zBetween;
    end if ;
  end process ;-- flagsPro

end architecture ;  -- dataflow



