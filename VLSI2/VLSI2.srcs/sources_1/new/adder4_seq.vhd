Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder4_seq is
    Port (
     clk     : STD_LOGIC;
     rst     : STD_LOGIC;
     inputA  : in STD_LOGIC_VECTOR(3 downto 0);
     inputB  : in STD_LOGIC_VECTOR(3 downto 0);
     Cin     : in STD_LOGIC;
     outputS : out STD_LOGIC_VECTOR(3 downto 0);
     Cout    : out STD_LOGIC
     );
end adder4_seq;



architecture Behavioral of adder4_seq is
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
    
    signal inA1 : STD_LOGIC_VECTOR(2 downto 0);
    signal inB1 : STD_LOGIC_VECTOR(2 downto 0);
    signal inA2 : STD_LOGIC_VECTOR(1 downto 0);
    signal inB2 : STD_LOGIC_VECTOR(1 downto 0);
    signal inA3 : STD_LOGIC;
    signal inB3 : STD_LOGIC;
    --signal inC : STD_LOGIC;
    signal Carry : STD_LOGIC_VECTOR(3 downto 0);
    signal Carry_reg : STD_LOGIC_VECTOR(3 downto 0);
    signal Sout : STD_LOGIC_VECTOR(3 downto 0);
    signal sum1 : STD_LOGIC;
    signal sum2 : STD_LOGIC_VECTOR(1 downto 0);
    signal sum3 : STD_LOGIC_VECTOR(2 downto 0);
    --signal sum : STD_LOGIC_VECTOR(3 downto 0);
begin
    FA0 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inputA(0),
    inputB(0),
    Cin,
    Carry(0),
    Sout(0)
);
FA1 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA1(0),
    inB1(0),
    Carry(0),
    Carry(1),
    Sout(1)
    );
FA2 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA2(0),
    inB2(0),
    Carry(1),
    Carry(2),
    Sout(2)
    );
FA3 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA3,
    inB3,
    Carry(2),
    Carry(3),
    Sout(3)
    );
    
    process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                inA1 <= (others => '0');
                inB1 <= (others => '0');
                inA2 <= (others => '0');
                inB2 <= (others => '0');
                inA3 <= '0';
                inB3 <= '0';
                Carry_reg <= (others => '0');
                --inC <= '0';
                outputS <= (others => '0');
                sum1 <= '0';
                sum2 <= (others => '0');
                sum3 <= (others => '0');
            else
                inA3 <= inA2(1);
                inA2 <= (1 => inA1(2), 0 => inA1(1));
                inA1 <= (2 => inputA(3), 1 => inputA(2), 0 => inputA(1));
                inB3 <= inB2(1);
                inB2 <= (1 => inB1(2), 0 => inB1(1));
                inB1 <= (2 => inputB(3), 1 => inputB(2), 0 => inputB(1));
                outputS <= Sout(3) & sum3;
                sum3 <= Sout(2) & sum2;
                sum2 <= (1 => Sout(1), 0 => sum1); 
                sum1 <= Sout(0);                   
                --outputS <= sum;
                --inA <= inputA;
                --inB <= inputB;
                --inC <= Cin;
                Carry_reg <= Carry;
            end if;
        end if;
    end process;
    Cout <= Carry_reg(3);


end Behavioral;
