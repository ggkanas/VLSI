library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity adder4_comb_tb is
end adder4_comb_tb;

architecture Behavioral of adder4_comb_tb is

    component adder4_comb is
        port(
         inputA  : in STD_LOGIC_VECTOR(3 DOWNTO 0);
         inputB  : in STD_LOGIC_VECTOR(3 DOWNTO 0);
         Cin     : in STD_LOGIC;
         outputS : out STD_LOGIC_VECTOR(3 DOWNTO 0);
         Cout    : out STD_LOGIC 
        );
    end component;
        
    signal inputA : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal inputB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Cin : STD_LOGIC;
    signal Cout : STD_LOGIC;
    signal outputS : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    constant TIME_DELAY : time := 5 ns;

begin

    uut : adder4_comb
     port map(
        inputA,
        inputB,
        Cin,
        outputS,
        Cout
     );

    stimulus : process
    begin
        Cin <= '0';
        for i in 0 to 15 loop
            inputA <= std_logic_vector(to_unsigned(i, 4));
            for j in 0 to 15 loop
                inputB <= std_logic_vector(to_unsigned(j, 4));
                wait for TIME_DELAY;
            end loop;
        end loop;
        Cin <= '1';
        for i in 0 to 15 loop
             inputA <= std_logic_vector(to_unsigned(i, 4));
             for j in 0 to 15 loop
                 inputB <= std_logic_vector(to_unsigned(j, 4));
                 wait for TIME_DELAY;
             end loop;
         end loop;
         inputA <= (others => '0');
         inputB <= (others => '0');
         Cin <= '0';
         wait;
    end process;

end Behavioral;
