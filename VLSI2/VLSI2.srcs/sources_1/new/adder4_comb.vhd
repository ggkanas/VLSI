library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder4_comb is
    Port (
     inputA  : in STD_LOGIC_VECTOR(3 downto 0);
     inputB  : in STD_LOGIC_VECTOR(3 downto 0);
     Cin     : in STD_LOGIC;
     outputS : out STD_LOGIC_VECTOR(3 downto 0);
     Cout    : out STD_LOGIC
     );
end adder4_comb;

architecture Structural of adder4_comb is
component full_adder_comb_struct is
    port(
     inputA  : in STD_LOGIC;
     inputB  : in STD_LOGIC;
     Cin     : in STD_LOGIC;
     Cout    : out STD_LOGIC;
     outputS : out STD_LOGIC 
    );
end component;

    signal Carry : STD_LOGIC_VECTOR(2 downto 0);

begin
    FA0 : full_adder_comb_struct
     port map(
        inputA(0),
        inputB(0),
        Cin,
        Carry(0),
        outputS(0)
    );
    FA1 : full_adder_comb_struct
     port map(
        inputA(1),
        inputB(1),
        Carry(0),
        Carry(1),
        outputS(1)
        );
    FA2 : full_adder_comb_struct
     port map(
        inputA(2),
        inputB(2),
        Carry(1),
        Carry(2),
        outputS(2)
        );
    FA3 : full_adder_comb_struct
     port map(
        inputA(3),
        inputB(3),
        Carry(2),
        Cout,
        outputS(3)
        );
 
end Structural;

   
