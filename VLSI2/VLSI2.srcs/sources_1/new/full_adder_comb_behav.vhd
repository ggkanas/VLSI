library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_comb_behav is
    Port (inputA  : in STD_LOGIC;
          inputB  : in STD_LOGIC;
          Cin     : in STD_LOGIC;
          Cout    : out STD_LOGIC;
          outputS : out STD_LOGIC);
end full_adder_comb_behav;

architecture FA_behavioral of full_adder_comb_behav is

    signal sum : STD_LOGIC_VECTOR(1 downto 0);
    signal vect1 : STD_LOGIC_VECTOR(0 downto 0);
    signal vect2 : STD_LOGIC_VECTOR(0 downto 0);
    signal vect3 : STD_LOGIC_VECTOR(0 downto 0);

begin
    process
    begin
        vect1 <= (0 => inputA);
        vect2 <= (0 => inputB);
        vect3 <= (0 => Cin);
        sum <= ('0' & vect1) + ('0'& vect2) + ('0' & vect3);
    end process;
    outputS <= sum(0);
    Cout <= sum(1);
end FA_behavioral;
