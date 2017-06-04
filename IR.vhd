
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity InstructionRegister is
  port (
	IRLoad : IN std_logic;
	inputIR: IN std_logic_vector (31 DOWNTO 0);
	clk : IN std_logic;
	outputIR: OUT std_logic_vector (31 DOWNTO 0)
  ) ;
end entity ; -- InstructionRegister

architecture dataflow of InstructionRegister is

begin

AIpro : process( clk )
begin
	if clk = '1' then
		if IRLoad = '1' then
			outputIR <= inputIR;
		end if ;
	end if ;
end process ; -- AIpro

end architecture ; -- dataflow
