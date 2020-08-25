library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Fuct : in  STD_LOGIC_VECTOR (5 downto 0);
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ALUControl : out  STD_LOGIC_VECTOR(2 downto 0);
			  Jump : out STD_LOGIC;
			  CLK : in STD_LOGIC;
			  RegOut : out STD_LOGIC;
			  InstWrite : in STD_LOGIC;
			  RegRead : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is
shared variable count : STD_LOGIC_VECTOR(1 downto 0) := "00";
shared variable countAddI : STD_LOGIC_VECTOR(1 downto 0) := "00";
shared variable countLW : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
	Main : process(OpCode, InstWrite, CLK)
	begin
		if OpCode'event then
			count := "00";
			countLW := "00";
			countAddI := "00";
		end if;
		RegOut <= 'X';
		if InstWrite = '1' then
			Branch <= '0';
			Jump <= '0';
	--	R Type instruction for arithmetic(add/sub/and/or/SLT)
		elsif OpCode = "000000" then
			if Fuct = "000000" then
				ALUControl <= "010";
			elsif Fuct = "000001" then
				ALUControl <= "110";
			elsif Fuct = "000010" then
				ALUControl <= "000";
			elsif Fuct = "000011" then
				ALUControl <= "001";
			elsif Fuct = "000100" then
				ALUControl <= "111";
			end if;
			RegDst <= '1';
			ALUSrc <= '0';
			MemWrite <= '0';
			MemtoReg <= '0';
			Branch <= '0';
			Jump <= '0';
			if count = "00" then
				RegRead <= '1';
				count := count + 1;
			elsif count = "10" then
				RegWrite <= '1';
				count := "00";
			else
				count := count + 1;
			end if;
		--	Load word from memory to register
		elsif OpCode = "100011" then
			MemtoReg <= '1';
			MemWrite <= '0';
			Branch <= '0';
			ALUSrc <= '1';
			RegDst <= '0';
			Jump <= '0';
			ALUControl <= "010";
			if countLW = "00" then
				RegRead <= '1';
				countLW := countLW + 1;
			elsif countLW = "10" then
				RegWrite <= '1';
				countLW := "00";
			else
				countLW := countLW + 1;
			end if;
		--	Store word (to memory)
		elsif OpCode = "101011" then
			MemWrite <= '1';
			Branch <= '0';
			ALUSrc <= '1';
			RegWrite <= '0';
			Jump <= '0';
			ALUControl <= "010";
			RegRead <= '1';
		--	Branch Equal
		elsif OpCode = "000100" then
			MemWrite <= '0';
			Branch <= '1';
			ALUSrc <= '0';
			RegWrite <= '0';
			Jump <= '0';
			RegRead <= '1';
		--	J : Jump
		elsif OpCode = "000101" then 
			MemWrite <= '0';
			RegWrite <= '0';
			Jump <= '1';
			RegRead <= '0';
		--	Add Immediate
		elsif OpCode = "001000" then
			MemtoReg <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUSrc <= '1';
			RegDst <= '0';
			ALUControl <= "010";
			Jump <= '0';
			if countAddI = "00" then
				RegRead <= '1';
				countAddI := countAddI + 1;
			elsif countAddI = "10" then
				RegWrite <= '1';
				countAddI := "00";
			else
				countAddI := countAddI + 1;
			end if;
		--	Print register data
		elsif OpCode = "111111" then
			ALUSrc <= '0';
			MemWrite <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			Branch <= '0';
			Jump <= '0';
			RegOut <= '1';
			RegRead <= '1';
		--Print memory data
		elsif OpCode = "111110" then
			MemtoReg <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUSrc <= '1';
			RegWrite <= '0';
			Jump <= '0';
			RegOut <= '0';
			RegRead <= '1';
		end if;
	end process;	
end Behavioral;