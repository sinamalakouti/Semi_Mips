library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity RF is
  port (
	clk : IN std_logic;
	inputRF: IN std_logic_vector (31 DOWNTO 0);
	RFwrite , switch: IN std_logic;
	in1Adr , in2Adr , outAdr : IN std_logic_vector (3 DOWNTO 0);
	outputRFA: OUT std_logic_vector (31 DOWNTO 0);
	outputRFB: OUT std_logic_vector (31 DOWNTO 0);
	ZeroOut : OUT std_logic
  ) ;
end entity ; -- RF

architecture arch of RF is

	type registers is array (0 to 15) of std_logic_vector( 31 DOWNTO 0 );
	signal myRegisters : registers := (others => (others => '0'));
	
begin
	myRegisters(to_integer(unsigned(outAdr))) <= inputRF when RFwrite='1' else
													myRegisters(to_integer(unsigned(outAdr)));

	ZeroOut <= '1' when myRegisters(0) = "00000000000000000000000000000000" else '0';


	 --not (
		--myRegisters(0)(0) or myRegisters(0)(1) or myRegisters(0)(2) or myRegisters(0)(3) or
		--myRegisters(0)(4) or myRegisters(0)(5) or myRegisters(0)(6) or myRegisters(0)(7) or
		--myRegisters(0)(8) or myRegisters(0)(9) or myRegisters(0)(10) or myRegisters(0)(11) or
		--myRegisters(0)(12) or myRegisters(0)(13) or myRegisters(0)(14) or myRegisters(0)(15) or
		--myRegisters(0)(16) or myRegisters(0)(17) or myRegisters(0)(18) or myRegisters(0)(19) or
		--myRegisters(0)(20) or myRegisters(0)(21) or myRegisters(0)(22) or myRegisters(0)(23) or
		--myRegisters(0)(24) or myRegisters(0)(25) or myRegisters(0)(26) or myRegisters(0)(27) or
		--myRegisters(0)(28) or myRegisters(0)(29) or myRegisters(0)(30) or myRegisters(0)(31) 
		--);
	
	rfpro : process( clk )
	begin
		if clk='1' and clk'event then
			if switch = '0' then
				outputRFA <= myRegisters(to_integer(unsigned(in1Adr)));
		 		outputRFB <= myRegisters(to_integer(unsigned(in2Adr)));
			else
				outputRFA <= myRegisters(to_integer(unsigned(outAdr)));
		  		outputRFB <= myRegisters(to_integer(unsigned(in2Adr)));
			end if ;
		end if ;
	end process ; -- rfpro

end architecture ; -- arch

