library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port(
    A      : in std_logic;
    B      : in std_logic;
    Cin    : in std_logic;
    Output : out std_logic;
    Cout   : out std_logic);
end full_adder;

architecture arch of full_adder is
  component half_adder is
    port(
      A      : in std_logic;
      B      : in std_logic;
      Output : out std_logic;
      Carry  : out std_logic);
  end component;

  signal ANDone, XORone, ANDtwo, Outp : std_logic;
    begin
      h1: half_adder port map(A, B, XORone, ANDone);
      h2: half_adder port map(XORone, Cin, Outp, ANDtwo);
      Cout<= (ANDone or ANDtwo);
      output <= (Outp);
end arch;