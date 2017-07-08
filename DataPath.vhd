library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity DataPath is
  port (
	clk : in std_logic;
	Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 , Addi10 , Andi11 , Ori12  : IN std_logic;
	RFwrite ,switch : IN std_logic; 
	IRLoad : IN std_logic;
	EnablePC , IncPC : IN std_logic;
	IRorPC : IN std_logic;
	CarrySet , CarryReset , CLoad , ZSet , ZReset: IN std_logic;
	readmem , writemem : IN std_logic ;
	memToDataBus , aluToDataBus : IN std_logic;
	IRData : OUT std_logic_vector (31 downto 0);
	memdataready : OUT std_logic;
	Cout , Zout : OUT std_logic
  ) ;
end entity ; -- DataPath

architecture arch of DataPath is

	component ALU is
	  port (
		Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9 , Addi10 , Andi11 , Ori12  : IN std_logic;
		in1, in2 : IN std_logic_vector (31 DOWNTO 0);
		carryIn : In std_logic;
		I : IN std_logic_vector (15 downto 0);
		amount : IN std_logic_vector(4 downto 0);
		res : OUT std_logic_vector (31 DOWNTO 0);
		carryOut : out std_logic;
		clk : in std_logic
	  ) ;
	end component ; -- ALU

	component RF is
	  port (
		clk : IN std_logic;
		inputRF: IN std_logic_vector (31 DOWNTO 0);
		RFwrite , switch : IN std_logic;
		in1Adr , in2Adr , outAdr : IN std_logic_vector (3 DOWNTO 0);
		outputRFA: OUT std_logic_vector (31 DOWNTO 0);
		outputRFB: OUT std_logic_vector (31 DOWNTO 0);
		ZeroOut : OUT std_logic
	  ) ;
	end component ; -- RF

	component IR is
	  port (
		IRLoad : IN std_logic;
		inputIR: IN std_logic_vector (31 DOWNTO 0);
		clk : IN std_logic;
		outputIR: OUT std_logic_vector (31 DOWNTO 0)
	  ) ;
	end component ; -- IR

	component PC is
	  port (
		EnablePC : IN std_logic;
		IncPC : IN std_logic;
		inputPC: IN std_logic_vector (23 DOWNTO 0);
		clk : IN std_logic;
		outputPC: OUT std_logic_vector (23 DOWNTO 0) := "000000000000000000000000"
	  ) ;
	end component ; -- PC

	component TrieState_32 is
	    port (
			inputB : IN std_logic_vector(31 DOWNTO 0);
			outputB : OUT std_logic_vector(31 DOWNTO 0);
			Control : IN std_logic
	  ) ;
	end component ; -- TrieState

	component Mem is
		port (clk, readmem, writemem : in std_logic;
			addressbus: in std_logic_vector (23 downto 0);
			input : in std_logic_vector (31 downto 0);
			output : out std_logic_vector (31 downto 0);
			memdataready : out std_logic);
	end component Mem; --Mem

	component mux2_24 is
	  port (
		inp0 , inp1 : IN std_logic_vector (23 downto 0);
		outp : OUT std_logic_vector (23 downto 0);
		controlling : IN std_logic
	  ) ;
	end component ; -- mux2_24

	component Flags is
	  port (
		Cin , CSet , CReset , CLoad , clk : IN std_logic;
		Cout : OUT std_logic;
		Zin , ZSet , ZReset : IN std_logic;
    	Zout : OUT std_logic
	  ) ;
	end component ; -- Flags

	signal RFOut1 , RFOut2 , ALUout , dataBus , IROut , memDataOutput : std_logic_vector(31 downto 0);
	signal addressBus , PCOut : std_logic_vector (23 downto 0);
	signal FlagsCarryOut , FlagsZeroOut , ALUCarrayOut , RFZeroOut : std_logic;


begin

	aluUnit : ALU PORT MAP (
			Add0, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9, Addi10 , Andi11 , Ori12,
			RFOut1 , RFOut2,
			FlagsCarryOut,
			IROut(15 downto 0),
			IROut(15 downto 11),
			ALUout ,
			ALUCarrayOut ,
			clk
		);

	RFUnit : RF PORT MAP (
			clk ,
			dataBus,
			RFwrite , switch,
			IROut(23 downto 20), IROut(19 downto 16) , IROut(27 downto 24),
			RFOut1,
			RFOut2,
			RFZeroOut
		);

	IRUnit : IR PORT MAP (
			IRLoad , 
			dataBus , 
			clk ,
			IROut
		);

	PCUnit : PC PORT MAP (
			EnablePC , 
			IncPC ,
			IROut (23 downto 0) ,
			clk ,
			PCOut
		);

	muxUnit : mux2_24 PORT MAP (
			IROut (23 downto 0), PCOut,
			addressBus,
			IRorPC 
		);

	flagsUnit : Flags PORT MAP (
			ALUCarrayOut , CarrySet , CarryReset , CLoad , clk ,
			FlagsCarryOut ,
			RFZeroOut , ZSet , ZReset ,
			FlagsZeroOut
		);

	memUnit : Mem 
	PORT MAP (
		clk , readmem , writemem ,
		addressBus ,
		dataBus ,
		memDataOutput,
		memdataready
		);

	memToDataBusUnit : TrieState_32 PORT MAP (
		memDataOutput , 
		dataBus ,
		memToDataBus
		);

	aluToDataBusUnit : TrieState_32 PORT MAP (
		ALUout , 
		dataBus ,
		aluToDataBus
		);

	IRData <= IROut;
	Cout <= FlagsCarryOut;
	Zout <= FlagsZeroOut;


end architecture ; -- arch
