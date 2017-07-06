library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mem is
	generic (blocksize : integer := 1024);

	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (24 downto 0);
		input : in std_logic_vector (31 downto 0);
		output : out std_logic_vector (31 downto 0);
		memdataready : out std_logic);
end entity Mem;

architecture behavioral of Mem is
	type mem is array (0 to blocksize - 1) of std_logic_vector (31 downto 0);
begin
	process (clk)
		variable buffermem : mem := (others => (others => '0'));
		variable ad : integer;
		variable init : boolean := true;
	begin
		if init = true then
			-- some initiation
		buffermem(0) := "1111000010000011";--mil
     	buffermem(1) := "1111000110000011";--mih
     	buffermem(2) := "1111010000001000";--mil
     	buffermem(3) := "1111010100000000";--mih
     	buffermem(4) := "0011010000101001";--sta lda
     	buffermem(5) := "0101011001001101";--oup inp
     	
			
			init := false;
		end if;

		--databus <= (others => 'Z');
		--memdataready <= '0';

		if  clk'event and clk = '1' then
			ad := to_integer(unsigned(addressbus));

			if readmem = '1' then -- Readiing :)
				memdataready <= '1';
				if ad >= blocksize then
					output <= (others => 'Z');
				else
					output <= buffermem(ad);
				end if;
			elsif writemem = '1' then -- Writing :)
				memdataready <= '1';
				if ad < blocksize then
					buffermem(ad) := input;
				end if;
			else 
			  memdataready <= '0';

			end if;
		end if;
	end process;
end architecture behavioral;

