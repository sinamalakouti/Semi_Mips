library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Controller is
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
end entity ; -- Controller
