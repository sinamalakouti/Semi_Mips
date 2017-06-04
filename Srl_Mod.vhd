library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Srl_Mod is
  port (
	in1 : in std_logic_vector(31 downto 0);
	in2 : in std_logic_vector(31 downto 0);
	carryIn : in std_logic;
	res : out std_logic_vector(31 downto 0);
	carryOut : out std_logic;
	amount : in std_logic_vector(4 downto 0);
	realClk : in std_logic
  ) ;
end entity ; -- Srl_Mod

architecture arch of Srl_Mod is
	
	signal clk : std_logic;
	signal counter : std_logic_vector(4 downto 0);
	signal var : std_logic_vector(31 downto 0);

begin

	ClockGen: process
    begin
      while true loop
          	clk <= '0';
            wait for 1 ns;
            clk <= '1';
            wait for 1 ns;
        end loop;
        wait;
    end process ;

    b : process( realClk , clk )
    begin
    	if realClk = '1' and realClk'event then
    		counter <= amount;
    		var <= in1;
		elsif (clk = '1' and clk'event ) then
			if (counter /= "00000") then
	    		counter <= std_logic_vector(unsigned(counter) - "00001");
	    		var <= '0' & var(31 downto 1);
    		end if;
    	end if ;
    end process ; -- b

    carryOut <= carryIn;
    res <= var;

end architecture ; -- arch