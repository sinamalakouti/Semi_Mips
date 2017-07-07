library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--todo can be done in better ways.
entity ALU is
  port (
	Add0,Addi, And1, Sub2, Xor3, Or4, Mul5, Not6, Null7, Srl8, Sll9  : IN std_logic;
	in1, in2 : IN std_logic_vector (31 DOWNTO 0);
	carryIn : In std_logic;
	amount : IN std_logic_vector(4 downto 0);
	res : OUT std_logic_vector (31 DOWNTO 0);
	carryOut : out std_logic;
	clk : in std_logic
  ) ;
end entity ; -- ALU

architecture arch of ALU is

	component Add_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- Add_Mod

	component And_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- And_Mod

	component Sub_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- Sub_Mod

	component Xor_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- Xor_Mod

	component Or_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- Or_Mod

	component Mul_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- Mul_Mod

	component Not_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- NotModule

	component Nothing_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic
	  ) ;
	end component ; -- Nothing_Mod

	component Srl_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic;
		amount : in std_logic_vector(4 downto 0);
		realClk : in std_logic
	  ) ;
	end component ; -- Srl_Mod

	component Sll_Mod is
	  port (
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		carryIn : in std_logic;
		res : out std_logic_vector(31 downto 0);
		carryOut : out std_logic;
		amount : in std_logic_vector(4 downto 0);
		realClk : in std_logic
	  ) ;
	end component ; -- Sll_Mod

	type resultArray is array (0 to 9) of std_logic_vector( 31 DOWNTO 0 );
	type carryArray is array (0 to 9) of std_logic;
	signal chooser : std_logic_vector(9 DOWNTO 0);
	signal outputs : resultArray;
	signal Carry : carryArray;

begin

	chooser <= (Add0 & And1 & Sub2 & Xor3 & Or4 & Mul5 & not6 & Null7 & Srl8 & Sll9);

	addM     : Add_Mod     port map (in1 , in2 , carryIn , outputs(0) , Carry(0));
	andM     : And_Mod     port map (in1 , in2 , carryIn , outputs(1) , Carry(1));
	subM     : Sub_Mod     port map (in1 , in2 , carryIn , outputs(2) , Carry(2));
	xorM     : Xor_Mod     port map (in1 , in2 , carryIn , outputs(3) , Carry(3));
	orM      : Or_Mod      port map (in1 , in2 , carryIn , outputs(4) , Carry(4));
	mulM     : Mul_Mod     port map (in1 , in2 , carryIn , outputs(5) , Carry(5));
	notM     : Not_Mod     port map (in1 , in2 , carryIn , outputs(6) , Carry(6));
	nothingM : Nothing_Mod port map (in1 , in2 , carryIn , outputs(7) , Carry(7));
	srlM     : Srl_Mod     port map (in1 , in2 , carryIn , outputs(8) , Carry(8) , amount , clk);
	sllM     : Sll_Mod     port map (in1 , in2 , carryIn , outputs(9) , Carry(9) , amount , clk);

    res  <= outputs(0 ) when chooser = "1000000000" else
			outputs(1 ) when chooser = "0100000000" else
			outputs(2 ) when chooser = "0010000000" else
			outputs(3 ) when chooser = "0001000000" else
			outputs(4 ) when chooser = "0000100000" else
			outputs(5 ) when chooser = "0000010000" else
			outputs(6 ) when chooser = "0000001000" else
			outputs(7 ) when chooser = "0000000100" else
			outputs(8 ) when chooser = "0000000010" else
			outputs(9 ) when chooser = "0000000001" else
			"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

	carryOut <= Carry(0 ) when chooser = "1000000000" else
				Carry(1 ) when chooser = "0100000000" else
				Carry(2 ) when chooser = "0010000000" else
				Carry(3 ) when chooser = "0001000000" else
				Carry(4 ) when chooser = "0000100000" else
				Carry(5 ) when chooser = "0000010000" else
				Carry(6 ) when chooser = "0000001000" else
				Carry(7 ) when chooser = "0000000100" else
				Carry(8 ) when chooser = "0000000010" else
				Carry(9 ) when chooser = "0000000001" else
				'X';

end architecture ; -- arch
