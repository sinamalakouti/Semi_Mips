library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Main is
end entity ; -- Main

architecture arch of Main is

	component DataPath is
	  port (
		clk : in std_logic;
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 , Addi10 , Andi11 , Ori12  : IN std_logic;
		RFwrite , switch : IN std_logic;
		IRLoad : IN std_logic;
		EnablePC , IncPC : IN std_logic;
		IRorPC : IN std_logic;
		CarrySet , CarryReset , CLoad , ZSet , ZReset : IN std_logic;
		readmem , writemem : IN std_logic ;
		memToDataBus , aluToDataBus : IN std_logic;
		IRData : out std_logic_vector (31 downto 0);
		memdataready : out std_logic;
		Cout , Zout : OUT std_logic
	  ) ;
	end component ; -- DataPath

	component Controller is
	  port (
		clk : in std_logic;
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 , Addi10 , Andi11 , Ori12  : out std_logic;
		RFwrite , switch : out std_logic;
		IRLoad : out std_logic;
		EnablePC , IncPC : out std_logic;
		IRorPC : out std_logic;
		CarrySet , CarryReset , CLoad , ZSet , ZReset : out std_logic;
		readmem , writemem : out std_logic ;
		memToDataBus , aluToDataBus : out std_logic;
		IROut : in std_logic_vector(31 downto 0);
		memdataready : IN std_logic;
		Cout , Zout : in std_logic
	  ) ;
	end component ; -- Controller



	signal clk ,
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 , Addi10 , Andi11 , Ori12,
		RFwrite , switch ,
		IRLoad ,
		EnablePC , IncPC ,
		IRorPC ,
		CarrySet , CarryReset , CLoad , ZSet , ZReset ,
		readmem , writemem ,
		memToDataBus , aluToDataBus , memdataready ,
		Cout , Zout : std_logic;
	signal IRData : std_logic_vector (31 downto 0);


begin

	dp : DataPath
	  port map(
		clk ,
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 , Addi10 , Andi11 , Ori12,
		RFwrite , switch ,
		IRLoad ,
		EnablePC , IncPC ,
		IRorPC ,
		CarrySet , CarryReset , CLoad , ZSet , ZReset , 
		readmem , writemem ,
		memToDataBus , aluToDataBus ,
		IRData,
		memdataready ,
		Cout , Zout
	  ) ;

	co : Controller
	  port map(
		clk ,
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9, Addi10 , Andi11 , Ori12 ,
		RFwrite , switch ,
		IRLoad ,
		EnablePC , IncPC ,
		IRorPC ,
		CarrySet , CarryReset , CLoad , ZSet , ZReset , 
		readmem , writemem ,
		memToDataBus , aluToDataBus ,
		IRData,
		memdataready ,
		Cout , Zout
	  ) ;

ClockGen: process
    begin
    clk <= '1';
    wait for 50 ns;
      while true loop
          clk <= '0';
            wait for 50 ns;
            clk <= '1';
            wait for 50 ns;
        end loop;
        wait;
    end process ;

end architecture ; -- arch
