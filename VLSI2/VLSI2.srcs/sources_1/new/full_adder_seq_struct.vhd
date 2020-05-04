library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_seq_struct is
    Port (clk : STD_LOGIC;
          rst : STD_LOGIC;
          inputA  : in STD_LOGIC;
          inputB  : in STD_LOGIC;
          Cin     : in STD_LOGIC;
          Cout    : out STD_LOGIC;
          outputS : out STD_LOGIC);
end full_adder_seq_struct;

architecture FA_structural of full_adder_seq_struct is

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
    signal sum   : STD_LOGIC;
    signal inA   : STD_LOGIC;
    signal inB   : STD_LOGIC;
    signal inC   : STD_LOGIC;
begin
    HA1 : half_adder
     port map(
        inA,
        inB,
        outS1,
        outC1
     );
    HA2 : half_adder
     port map(
        inC,
        outS1,
        sum,
        outC2
     );
     process(clk)
     begin
     if rising_edge(clk) then
        if rst='1' then
            --Cout <= '0';
            --outputS <= '0';
            inA <= '0';
            inB <= '0';
            inC <= '0';
        else
            inA <= inputA;
            inB <= inputB;
            inC <= Cin;
            --Cout <= outC1 or outC2;
            --outputS <= sum;
        end if;

     end if;
   
     end process;
     Cout <= outC1 or outC2;
     outputS <= sum;
end FA_structural;
