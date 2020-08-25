library ieee;
use ieee.std_logic_1164.all;

entity BitwiseOpsAll is
  generic (
    size : integer := 8);
  port(
    opcode    : in std_logic_vector (3 downto 0);
    A   : in std_logic_vector (3 downto 0);
    B   : in std_logic_vector (3 downto 0);
    Output : out std_logic_vector(3 downto 0));
end BitwiseOpsAll;

architecture arch of BitwiseOpsAll is
  signal op   : std_logic_vector (3 downto 0);
  begin
    op <= opcode;
  process (op, A, B)
    begin 
      case op is
        when ("0010") => Output <= (A AND B);
        when ("0011") => Output <= (A OR B);
        when ("0100") => Output <= (A XOR B);
        when ("0101") => Output <= (NOT A);
          
        when ("0110") => Output <= to_stdlogicvector(to_bitvector(A) SLL 1);
        when ("0111") => Output <= to_stdlogicvector(to_bitvector(A) SRL 1);
        when ("1000") => Output <= to_stdlogicvector(to_bitvector(A) ROL 1);
        when ("1001") => Output <= to_stdlogicvector(to_bitvector(A) ROR 1);
          
        when others => null;
      end case;
    end process;
    
end arch;