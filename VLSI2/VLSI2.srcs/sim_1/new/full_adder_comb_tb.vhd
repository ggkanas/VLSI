library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity full_adder_comb_tb is
end full_adder_comb_tb;

architecture Behavioral of full_adder_comb_tb is

    component full_adder_comb_struct is
        port(
         inputA  : in STD_LOGIC;
         inputB  : in STD_LOGIC;
         Cin     : in STD_LOGIC;
         Cout    : out STD_LOGIC;
         outputS : out STD_LOGIC 
        );
    end component;
    component full_adder_comb_behav is
        port(
         inputA  : in STD_LOGIC;
         inputB  : in STD_LOGIC;
         Cin     : in STD_LOGIC;
         Cout    : out STD_LOGIC;
         outputS : out STD_LOGIC 
        );
    end component;
        
    signal inputA : STD_LOGIC;
    signal inputB : STD_LOGIC;
    signal Cin : STD_LOGIC;
    signal Cout1 : STD_LOGIC;
    signal outputS1 : STD_LOGIC;
    signal Cout2 : STD_LOGIC;
    signal outputS2 : STD_LOGIC;
    
    constant TIME_DELAY : time := 5 ns;

begin
    uut1 : full_adder_comb_struct
     port map (
        inputA,
        inputB,
        Cin,
        Cout1,
        outputS1
     );
    uut2 : full_adder_comb_behav
     port map (
        inputA,
        inputB,
        Cin,
        Cout2,
        outputS2
     );
    stimulus : process
    begin
        inputA <= '0';
        inputB <= '0';
        Cin <= '0';
        wait for TIME_DELAY;
        inputA <= '1';
        wait for TIME_DELAY;
        inputB <= '1';
        wait for TIME_DELAY;
        inputA <= '0';
        wait for TIME_DELAY;
        Cin <= '1';
        wait for TIME_DELAY;
        inputA <= '1';
        wait for TIME_DELAY;
        inputB <= '0';
        wait for TIME_DELAY;
        inputA <= '0';
        wait for TIME_DELAY;
        Cin <= '0';
        wait;
    end process;

end Behavioral;
