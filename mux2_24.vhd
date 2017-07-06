library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity mux2_24 is
  port (
	inp0 , inp1 : IN std_logic_vector (23 downto 0);
	outp : OUT std_logic_vector (23 downto 0);
	controlling : IN std_logic
  ) ;
end entity ; -- mux2_24

architecture arch of mux2_24 is

begin

	outp <= inp0 when ((controlling) = '0') 
				else inp1;

end architecture ; -- arch


