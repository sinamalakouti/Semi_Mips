library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Nothing_Mod is
  port (
	in1 : in std_logic_vector(31 downto 0);
	in2 : in std_logic_vector(31 downto 0);
	carryIn : in std_logic;
	res : out std_logic_vector(31 downto 0);
	carryOut : out std_logic
  ) ;
end entity ; -- Nothing_Mod

architecture arch of Nothing_Mod is

begin

	res <= in1;
	carryOut <= carryIn;

end architecture ; -- arch
