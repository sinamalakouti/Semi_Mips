library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity TrieState_32 is
  port (
	inputB : IN std_logic_vector(31 DOWNTO 0);
	outputB : OUT std_logic_vector(31 DOWNTO 0);
	Control : IN std_logic
  ) ;
end entity ; -- TrieState

architecture arch of TrieState_32 is

begin

	outputB <= inputB when (Control = '1') else "ZZZZZZZZZZZZZZZZ";

end architecture ; -- arch
