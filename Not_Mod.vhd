library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Not_Mod is
  port (
	in1 : in std_logic_vector(31 downto 0);
	in2 : in std_logic_vector(31 downto 0);
	carryIn : in std_logic;
	res : out std_logic_vector(31 downto 0);
	carryOut : out std_logic
  ) ;
end entity ; -- NotModule

architecture arch of Not_Mod is

begin

	res <= not in1;
	carryOut <= carryIn;

end architecture ; -- arch
