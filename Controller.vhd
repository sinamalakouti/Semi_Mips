library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Controller is
  port (
	clk : in std_logic;
	Add0, And1 ,  Sub2 , Xor3 , Or4 , Mul5 , Not6 , Null7 , Srl8 , Sll9 , Addi10 , Andi11 , Ori12  : out std_logic;
	RFwrite , switch : out std_logic;
	IRLoad : out std_logic;
	EnablePC , IncPC : out std_logic;
	IRorPC : out std_logic;
	CarrySet , CarryReset , CLoad , ZSet , ZReset: out std_logic;
	readmem , writemem : out std_logic ;
	memToDataBus , aluToDataBus : out std_logic;
  IROut : in std_logic_vector(31 downto 0);
  memdataready : IN std_logic;
  Cout , Zout : in std_logic
  ) ;
end entity;

architecture arch of Controller is

--type states is  ( reset , fetch , decode , halt, pcInc , prefetch);
type states is ( reset , prefetch , fetch , decode , add_0 , addi_0 , sub_0 , and_0 , andi_0 , or_0 , ori_0 , xor_0 , not_0 , mul_0 , 
                jmp_0 , sll_0 , srl_0 , str_0 , lda_0 , brnz_0 );
signal currentState : states := reset;
signal nextState : states;
begin


process(clk)
  begin

    if clk'event and clk ='1' then
      currentState <= nextState;
    end if;

    switch <= '0';
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

      when reset =>
        nextState <= prefetch;

      when prefetch =>
        memToDataBus <= '1';
        readmem <= '1';
        IRLoad <= '1';
        if (memdataready = '0') then 
          nextState <= prefetch;
        else 
          nextState <= fetch;
        end if;

      when fetch =>
        memToDataBus <= '1';
        readmem <= '1';
        IRLoad <= '1';
        nextState <= decode;

      when decode =>
        case(IROut(31 downto 28)) is
          -- add
          when  "0000" =>
           nextState <= add_0;

          --  add i
          when "0001" =>
            nextState <= addi_0;

          -- subtract
          when "0010" =>
              nextState <= sub_0;

          --  and
          when "0011" =>
            nextState <= and_0;

          --  and i
          when "0100" =>
            nextState <= andi_0;

          --  or
          when "0101" =>
            nextState <= or_0;

          --  or i
          when "0110" =>
            nextState <= ori_0;

          --  xor
          when "0111" =>
            nextState <= xor_0;

          --  not
          when "1000" =>
              nextState <= not_0;

          -- multiply
          when "1001" =>
            nextState <= mul_0;

          -- jmp
          when "1010" =>
            nextState  <= jmp_0;

          -- sll9
          when "1011" =>
          nextState <= sll_0;

          -- Srl8
          when "1100" =>
          nextState <= srl_0;

          -- store
          when "1101" =>
          nextState <= str_0;

          --  load
          when "1110" =>
          switch <= '1';
          nextState <= lda_0;

          --  brnz
          when "1111" =>
          nextState <= brnz_0;

          when others =>
        end case;

        when add_0 =>
           Add0 <= '1';
           IncPC <='1';
           RFwrite <= '1';
           aluToDataBus <='1';
           nextState <= prefetch;

        when addi_0 =>
            Addi10 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when sub_0 =>
            Sub2 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when and_0 =>
            And1 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when andi_0 =>
            Andi11 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when or_0 =>
            Or4 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when ori_0 =>
            Ori12 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when xor_0 =>
            Xor3 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when not_0 =>
            Not6 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when mul_0 =>
            Mul5 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when jmp_0 =>
            EnablePC <= '1';
            nextState <= prefetch;

        when sll_0 =>
            sll9 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when srl_0 =>
            Srl8 <= '1';
            IncPC <='1';
            RFwrite <= '1';
            aluToDataBus <='1';
            nextState <= prefetch;

        when str_0 =>
            switch <= '1';
            Null7 <= '1';
            aluToDataBus <= '1';
            IRorPC <= '0';
            writemem <= '1';
            if memdataready = '0' then
              nextState <= str_0;
            else 
              IncPC <= '1';
              nextState <= prefetch;
            end if ;

        when lda_0 =>
            IRorPC <= '0';
            RFwrite <= '1';
            readmem <= '1';
            memToDataBus <= '1';
            if memdataready = '0' then
              nextState <= lda_0;
            else 
              IncPC <= '1'; 
              nextState <= prefetch;
            end if ;

        when brnz_0 =>
            if Zout = '0' then
              EnablePC <= '1';
            else
              IncPC <= '1';  
            end if ;
            nextState <= prefetch;

      end case;
    end process;
end architecture;