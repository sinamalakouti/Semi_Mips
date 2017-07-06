library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Main is
end entity ; -- Main

architecture arch of Main is

	component DataPath is
	  port (
		clk : in std_logic;
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9  : IN std_logic;
		RFwrite : IN std_logic; 
		IRLoad : IN std_logic;
		EnablePC , IncPC : IN std_logic;
		IRorPC : IN std_logic;
		CarrySet , CarryReset , CLoad , ZSet , ZReset , ZLoad: IN std_logic;
		readmem , writemem : IN std_logic ;
		memToDataBus , aluToDataBus : IN std_logic;
		Cout , Zout : OUT std_logic
	  ) ;
	end component ; -- DataPath

	component Controller is
	  port (
		clk : in std_logic;
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9  : out std_logic;
		RFwrite : out std_logic; 
		IRLoad : out std_logic;
		EnablePC , IncPC : out std_logic;
		IRorPC : out std_logic;
		CarrySet , CarryReset , CLoad , ZSet , ZReset , ZLoad: out std_logic;
		readmem , writemem : out std_logic ;
		memToDataBus , aluToDataBus : out std_logic;
		Cout , Zout : in std_logic
	  ) ;
	end component ; -- Controller



	signal clk ,
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 ,
		RFwrite ,
		IRLoad ,
		EnablePC , IncPC ,
		IRorPC ,
		CarrySet , CarryReset , CLoad , ZSet , ZReset , ZLoad ,
		readmem , writemem ,
		memToDataBus , aluToDataBus ,
		Cout , Zout : std_logic;


begin

	dp : DataPath 
	  port map(
		clk ,
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 ,
		RFwrite ,
		IRLoad ,
		EnablePC , IncPC ,
		IRorPC ,
		CarrySet , CarryReset , CLoad , ZSet , ZReset , ZLoad ,
		readmem , writemem ,
		memToDataBus , aluToDataBus ,
		Cout , Zout 
	  ) ;

	co : Controller 
	  port map(
		clk ,
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 ,
		RFwrite ,
		IRLoad ,
		EnablePC , IncPC ,
		IRorPC ,
		CarrySet , CarryReset , CLoad , ZSet , ZReset , ZLoad ,
		readmem , writemem ,
		memToDataBus , aluToDataBus ,
		Cout , Zout 
	  ) ;

ClockGen: process
    begin
      while true loop
          clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end loop;
        wait;
    end process ;

end architecture ; -- arch