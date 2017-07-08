library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Controller is
  port (
	clk : in std_logic;
	Add0, And1 ,  Sub2 , Xor3 , Or4 , Mul5 , Not6 , Null7 , Srl8 , Sll9 , Addi10 , Andi11 , Ori12  : out std_logic;
	RFwrite : out std_logic;
	IRLoad : out std_logic;
	EnablePC , IncPC : out std_logic;
	IRorPC : out std_logic;
	CarrySet , CarryReset , CLoad , ZSet , ZReset , ZLoad: out std_logic;
	readmem , writemem : out std_logic ;
	memToDataBus , aluToDataBus : out std_logic;
  IROut : in std_logic_vector(31 downto 0);
  Cout , Zout : in std_logic
  ) ;
end entity;

architecture arch of Controller is

type states is  ( reset , fetch , decode , halt, pcInc, shiftRight, shiftLeft);
signal currentState : states := reset;
signal nextState : states;
begin

identifier : process(clk)
begin
  if clk'event and clk ='1' then
      currentState <= nextState;
  end if;

end process;


process(currentState)
  begin

    aluToDataBus <='0';
    IRLoad <= '0';
    EnablePC <= '0';
    IncPC <='0';
    memToDataBus <='0';
    readmem <='0';
    writemem <='0';
    CarrySet <='0';
    CarryReset<='0';
    CLoad<='0';
    ZSet <='0';
    ZReset <='0';
    IRorPC <= '1';
    RFwrite <= '0';
    Add0 <='0';
    Addi10 <= '0';
    And1 <= '0';
    Andi11 <= '0';
    Sub2 <='0';
    Xor3 <= '0';
    Or4 <= '0';
    Ori12 <='0';
    Mul5 <='0';
    Not6 <= '0';
    Null7 <= '0';
    Srl8 <= '0';
    Sll9 <= '0';
    case( currentState ) is

      when halt =>
        nextState <= halt;
      when reset =>
        EnablePC <='1';
        nextState <= fetch;
      when fetch =>
        readmem <= '1';
        IRLoad <= '1';
        nextState <= decode;
      when pcInc =>
          IncPC <='1';
          EnablePC <='1';
          nextState <= fetch;
      when decode =>
        case(IROut(31 downto 28)) is

          -- add
          when  "0000" =>
           Add0 <= '1';
           IncPC <='1';
           EnablePC <='1';
           aluToDataBus <='1';
           nextState <= fetch;

          --  add i
          when "0001" =>
            Addi10 <='1';
            IncPC <='1';
            EnablePC <='1';
            aluToDataBus <= '1';
            nextState <= fetch;

          -- subtract
          when "0010" =>
              sub2 <= '0';
              IncPC <='1';
              EnablePC <='1';
              aluToDataBus <='1';
              nextState <= fetch;

          --  and
          when "0011" =>
            And1 <='1';
            aluToDataBus <='1';
            IncPC <='1';
            EnablePC <='1';
            nextState <=fetch;

          --  and i
          when "0100" =>
            Andi11 <='1';
            aluToDataBus <='1';
            IncPC <='1';
            EnablePC <='1';
            nextState <=fetch;

          --  or
          when "0101" =>
            Or4 <='1';
            aluToDataBus <='1';
            IncPC<='1';
            EnablePC <='1';
            nextState <= fetch;

          --  or i
          when "0110" =>
            Ori12 <='1';
            aluToDataBus <='1';
            IncPC <='1';
            EnablePC <='1';
            nextState <= fetch;

          --  xor
          when "0111" =>
            Xor3 <= '1';
            aluToDataBus <='1';
            IncPC <='1';
            EnablePC <='1';
            nextState <= fetch;

          --  not
          when "1000" =>
              not6 <='1';
              IncPC <='1';
              EnablePC <= '1';
              aluToDataBus <='1';
              nextState <= fetch;

          -- multiply
          when "1001" =>
            Mul5 <='1';
            IncPC <='1';
            EnablePC <='1';
            aluToDataBus <='1';
            nextState <= fetch;

          -- jmp
          when "1010" =>
            Null7 <='1';
            aluToDataBus <='1';
            EnablePC <='1';
            nextState  <= fetch;

          -- sll9
          when "1011" =>
          sll9 <='1';
          aluToDataBus <='1';
          IncPC <='1';
          nextState <= fetch;

          -- Srl8
          when "1100" =>
          Srl8 <='1';
          aluToDataBus <='1';
          IncPC <='1';
          nextState <= fetch;

          -- store
          when "1101" =>
          IRorPC <= '0';
          -- IncPC <='1';
          Null7 <='1';
          aluToDataBus <='1';
          nextState <= pcInc;

          --  load
          when "1110" =>
          IRorPC <= '0';
          memToDataBus <='1';
          RFwrite <='1';
          -- IncPC <='1';
          nextState <=pcInc;

          --  brnz
          when "1111" =>
            if Zout = '1' then
                nextState <= fetch;
                IncPC <='1';
            else
                IncPC <='1';
                nextState <=fetch;
            end if;


        end case;

      when reset =>
      nextState <= reset;

    end case;

end process;




end architecture;
