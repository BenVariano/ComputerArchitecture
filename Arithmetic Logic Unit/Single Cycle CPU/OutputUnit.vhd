-- 16 bit output
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OutputUnit is
    Port ( RegOut : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           RdOut1 : in  STD_LOGIC_VECTOR (15 downto 0);
           MemOut : in  STD_LOGIC_VECTOR (15 downto 0);
           ssd_out: out std_logic_vector(55 downto 0);
           sign : out STD_LOGIC;
			  CLK : in STD_LOGIC);
end OutputUnit;



architecture Behavioral of OutputUnit is
 
component ssd is
port(
is_signed  : in std_logic;
bit_num    : in std_logic_vector(15 downto 0);
ssd_out    : out std_logic_vector(55 downto 0));
end component;  
  
begin
  sign <= 0;
	process(CLK)
	begin
		if rising_edge(CLK) then
			if RegOut = '0' then
				Output <= MemOut;
			elsif RegOut = '1' then
				Output <= RdOut1;
			end if;
		end if;
	end process;
sss: ssd port map( sign , MemOut , ssd_out );
end Behavioral;

--include the output to seven segment display and SSD files
--from masterfile in project 1 (file corrupted)
--ssd not implemented properly, come back to it
