library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is

    component half_adder is
        port(
        inputA  : in STD_LOGIC;
        inputB  : in STD_LOGIC;
        outputS : out STD_LOGIC;
        outputC : out STD_LOGIC
        );
    end component;

    signal inputA  : STD_LOGIC;
    signal inputB  : STD_LOGIC;
    signal outputS : STD_LOGIC;
    signal outputC : STD_LOGIC;
 
    constant TIME_DELAY : time := 5 ns;
begin
    uut : half_adder
     port map(
        inputA,
        inputB,
        outputS,
        outputC
     );
    stimulus : process
    begin
        inputA <= '0';
        inputB <= '0';
        wait for TIME_DELAY;
        inputA <= '1';
        wait for TIME_DELAY;
        inputB <= '1';
        wait for TIME_DELAY;
        inputA <= '0';
        wait for TIME_DELAY;
        inputB <= '0';
        wait;
    end process;

end Behavioral;
