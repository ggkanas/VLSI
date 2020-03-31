library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity full_adder_seq_tb is
end full_adder_seq_tb;

architecture Behavioral of full_adder_seq_tb is

    component full_adder_seq_struct is
        port(
         clk     : STD_LOGIC;
         rst     : STD_LOGIC;
         inputA  : in STD_LOGIC;
         inputB  : in STD_LOGIC;
         Cin     : in STD_LOGIC;
         Cout    : out STD_LOGIC;
         outputS : out STD_LOGIC 
        );
    end component;
    component full_adder_seq_behav is
        port(
         clk     : STD_LOGIC;
         rst     : STD_LOGIC;
         inputA  : in STD_LOGIC;
         inputB  : in STD_LOGIC;
         Cin     : in STD_LOGIC;
         Cout    : out STD_LOGIC;
         outputS : out STD_LOGIC 
        );
    end component;
    
    signal clk : STD_LOGIC;
    signal rst : STD_LOGIC;    
    signal inputA : STD_LOGIC;
    signal inputB : STD_LOGIC;
    signal Cin : STD_LOGIC;
    signal Cout1 : STD_LOGIC;
    signal outputS1 : STD_LOGIC;
    signal Cout2 : STD_LOGIC;
    signal outputS2 : STD_LOGIC;
    
    constant CLK_PERIOD : time := 10 ns;

begin
    uut1 : full_adder_seq_struct
     port map (
        clk,
        rst,
        inputA,
        inputB,
        Cin,
        Cout1,
        outputS1
     );
    uut2 : full_adder_seq_behav
     port map (
        clk,
        rst,
        inputA,
        inputB,
        Cin,
        Cout2,
        outputS2
     );
    stimulus : process
    begin
        rst <= '0';
        inputA <= '0';
        inputB <= '0';
        Cin <= '0';
        wait for CLK_PERIOD*5;
        rst <= '1';
        wait for CLK_PERIOD*5;
        rst <= '0';
        wait for CLK_PERIOD*5;
        inputA <= '1';
        wait for CLK_PERIOD;
        inputB <= '1';
        wait for CLK_PERIOD;
        inputA <= '0';
        wait for CLK_PERIOD;
        Cin <= '1';
        wait for CLK_PERIOD;
        inputA <= '1';
        wait for CLK_PERIOD;
        inputB <= '0';
        wait for CLK_PERIOD;
        inputA <= '0';
        wait for CLK_PERIOD;
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
