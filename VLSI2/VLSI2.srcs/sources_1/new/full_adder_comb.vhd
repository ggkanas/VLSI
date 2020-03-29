
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_comb_struct is
    Port (inputA  : in STD_LOGIC;
          inputB  : in STD_LOGIC;
          Cin     : in STD_LOGIC;
          Cout    : out STD_LOGIC;
          outputS : out STD_LOGIC);
end full_adder_comb_struct;

architecture FA_structural of full_adder_comb_struct is

component half_adder is
    port(
     inputA  : in STD_LOGIC;
     inputB  : in STD_LOGIC;
     outputS : out STD_LOGIC;
     outputC : out STD_LOGIC
    );
end component;
    signal outS1 : STD_LOGIC;
    signal outC1 : STD_LOGIC;
    signal outC2 : STD_LOGIC;
begin
    HA1 : half_adder
     port map(
        inputA,
        inputB,
        outS1,
        outC1
     );
    HA2 : half_adder
     port map(
        Cin,
        outS1,
        outputS,
        outC2
     );
     Cout <= outC1 or outC2;

end FA_structural;


