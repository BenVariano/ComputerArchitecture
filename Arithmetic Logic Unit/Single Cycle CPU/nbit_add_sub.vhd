library ieee;
use ieee.std_logic_1164.all;

entity nbit_add_sub is
  generic(
    size : integer := 8);
    
  port(
    A      : in std_logic_vector(7 downto 0);
    B      : in std_logic_vector(7 downto 0);
    Output : out std_logic_vector(7 downto 0);
    Cout   : out std_logic;
    S      : in std_logic;
    Ov     : out std_logic);
end nbit_add_sub;

architecture arch of nbit_add_sub is
  component full_adder is
    port(
      A      : in std_logic;
      B      : in std_logic;
      Cin    : in std_logic;
      Output : out std_logic;
      Cout   : out std_logic);
  end component;

  signal Q, C  : std_logic_vector (7 downto 0);
    begin
      Q(0) <= (B(0) XOR S);
      Q(1) <= (B(1) XOR S);
      Q(2) <= (B(2) XOR S);
      Q(3) <= (B(3) XOR S);
      Q(4) <= (B(4) XOR S);
      Q(5) <= (B(5) XOR S);
      Q(6) <= (B(6) XOR S);
      Q(7) <= (B(7) XOR S);
      
      ADD1: full_adder port map (A(0), Q(0), S, Output(0), C(0));
      ADD2: full_adder port map (A(1), Q(1), C(0), Output(1), C(1));
      ADD3: full_adder port map (A(2), Q(2), C(1), Output(2), C(2));
      ADD4: full_adder port map (A(3), Q(3), C(2), Output(3), C(3));
      ADD5: full_adder port map (A(4), Q(4), C(3), Output(4), C(4));
      ADD6: full_adder port map (A(5), Q(5), C(4), Output(5), C(5));
      ADD7: full_adder port map (A(6), Q(6), C(5), Output(6), C(6));
      ADD8: full_adder port map (A(7), Q(7), C(6), Output(7), C(7));
      
      Cout <= c(7);
      Ov <= (C(7) XOR C(6));
end arch;
