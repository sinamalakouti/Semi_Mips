library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Add_Mod is
  port (
	in1 : in std_logic_vector(31 downto 0);
	in2 : in std_logic_vector(31 downto 0);
	carryIn : in std_logic;
	res : out std_logic_vector(31 downto 0);
	carryOut : out std_logic
  ) ;
end entity ; -- Add_Mod

architecture arch of Add_Mod is

signal input1 , input2 ,temp: std_logic_vector(32 downto 0);

begin

	input1 <= in1(31) & in1;
	input2 <= in2(31) & in2;
	temp <= std_logic_vector(unsigned(in1) + unsigned(in2) + ("00000000000000000000000000000000" & carryIn));
	res <= temp (31 downto 0);
	carryOut <= temp(32);

end architecture ; -- arch