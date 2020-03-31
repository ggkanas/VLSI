library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity adder4_seq_tb is
end adder4_seq_tb;

architecture Behavioral of adder4_seq_tb is

    component adder4_seq is
        port(
         clk     : STD_LOGIC;
         rst     : STD_LOGIC;
         inputA  : in STD_LOGIC_VECTOR(3 DOWNTO 0);
         inputB  : in STD_LOGIC_VECTOR(3 DOWNTO 0);
         Cin     : in STD_LOGIC;
         outputS : out STD_LOGIC_VECTOR(3 DOWNTO 0);
         Cout    : out STD_LOGIC 
        );
    end component;
    
    signal clk : STD_LOGIC;
    signal rst : STD_LOGIC;    
    signal inputA : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal inputB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal Cin : STD_LOGIC;
    signal Cout : STD_LOGIC;
    signal outputS : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    constant CLK_PERIOD : time := 10 ns;

begin

    uut : adder4_seq
     port map(
        clk,
        rst,
        inputA,
        inputB,
        Cin,
        outputS,
        Cout
     );

    stimulus : process
    begin
        rst <= '0';
        inputA <= (others => '0');
        inputB <= (others => '0');
        Cin <= '0';
        wait for CLK_PERIOD*5;
        rst <= '1';
        wait for CLK_PERIOD*5;
        rst <= '0';
        wait for CLK_PERIOD*5;
        for i in 0 to 15 loop
            inputA <= std_logic_vector(to_unsigned(i, 4));
            for j in 0 to 15 loop
                inputB <= std_logic_vector(to_unsigned(j, 4));
                wait for CLK_PERIOD;
            end loop;
        end loop;
        Cin <= '1';
        for i in 0 to 15 loop
             inputA <= std_logic_vector(to_unsigned(i, 4));
             for j in 0 to 15 loop
                 inputB <= std_logic_vector(to_unsigned(j, 4));
                 wait for CLK_PERIOD;
             end loop;
         end loop;
         inputA <= (others => '0');
         inputB <= (others => '0');
         Cin <= '0';
         wait;
    end process;

  generate_clock : process
  begin
    clk <= '0';
    wait for CLK_PERIOD/2;
    clk <= '1';
    wait for CLK_PERIOD/2;
  end process;

end Behavioral;
