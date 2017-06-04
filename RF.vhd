library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity RF is
  port (
	clk : IN std_logic;
	inputRF: IN std_logic_vector (31 DOWNTO 0);
	RFwrite : IN std_logic;
	in1Adr , in2Adr , outAdr : IN std_logic_vector (3 DOWNTO 0);
	outputRFA: OUT std_logic_vector (31 DOWNTO 0);
	outputRFB: OUT std_logic_vector (31 DOWNTO 0)
  ) ;
end entity ; -- RF

architecture arch of RF is

	type registers is array (0 to 15) of std_logic_vector( 31 DOWNTO 0 );
	signal myRegisters : registers;
	
begin
	myRegisters(to_integer(unsigned(outAdr))) <= inputRF when RFwrite='1' else
													myRegisters(to_integer(unsigned(outAdr)));
	
	
	rfpro : process( clk )
	begin
		if clk='1' and clk'event then
		  outputRFA <= myRegisters(to_integer(unsigned(in1Adr)));
		  outputRFB <= myRegisters(to_integer(unsigned(in2Adr)));
		end if ;
	end process ; -- rfpro

end architecture ; -- arch

