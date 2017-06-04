
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity PC is
  port (
	EnablePC : IN std_logic;
	IncPC : IN std_logic;
	inputPC: IN std_logic_vector (31 DOWNTO 0);
	clk : IN std_logic;
	outputPC: OUT std_logic_vector (31 DOWNTO 0) := "00000000000000000000000000000000"
  ) ;
end entity ; -- PC

architecture dataflow of PC is

	signal outputTemp : std_logic_vector(31 DOWNTO 0);

begin

programcounterpro : process( clk )
begin
	if clk = '1' and clk'event then
		if IncPC = '1' then
			outputTemp <= std_logic_vector(unsigned(outputTemp) + "00000000000000000000000000000001");
		elsif EnablePC = '1' then
			outputTemp <= inputPC;
		end if ;
	end if ;
end process ; -- programcounterpro

outputPC <= outputTemp;

end architecture ; -- dataflow

