library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Mul_Mod is
  port (
	in1 : in std_logic_vector(31 downto 0);
	in2 : in std_logic_vector(31 downto 0);
	carryIn : in std_logic;
	res : out std_logic_vector(31 downto 0);
	carryOut : out std_logic
  ) ;
end entity ; -- Mul_Mod

architecture arch of Mul_Mod is

	component MullCell 
	   port (xi, yi, pi, ci : IN std_logic; 
	    po, co : OUT std_logic); 
	end component; 

	signal x : std_logic_vector(15 downto 0);
	signal y : std_logic_vector(15 downto 0);
	type pair is array (16 downto 0, 16 downto 0) OF std_logic;
	signal cv, pv : pair;

begin 
	   x <= in1 (15 downto 0);
	   y <= in2 (15 downto 0);

	   rows : FOR i IN x'RANGE GENERATE
	      cols : FOR j IN y'RANGE GENERATE
	         cel : MullCell PORT MAP (x (i), y (j), pv (i, j+1), cv (i, j), pv (i+1, j), cv (i, j+1));
	      END GENERATE;
	   END GENERATE; 
	   
	   sides : FOR i IN x'RANGE GENERATE
	      cv (i, 0) <= '0';
	      pv (0, i+1) <= '0';
	      pv (i+1, x'LENGTH) <= cv (i, x'LENGTH);
	      res (i) <= pv (i+1, 0);
	      res (i+x'LENGTH) <= pv (x'LENGTH, i+1);
	   END GENERATE;  

end architecture ; -- arch