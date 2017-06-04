library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity TrieState is
  port (
	inputB : IN std_logic_vector(15 DOWNTO 0);
	outputB : OUT std_logic_vector(15 DOWNTO 0);
	Control : IN std_logic
  ) ;
end entity ; -- TrieState

architecture arch of TrieState is

begin

	outputB <= inputB when (Control = '1') else "ZZZZZZZZZZZZZZZZ";

end architecture ; -- arch
