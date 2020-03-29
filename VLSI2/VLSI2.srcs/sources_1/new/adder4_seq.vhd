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
    
    signal inA : STD_LOGIC_VECTOR(3 downto 0);
    signal inB : STD_LOGIC_VECTOR(3 downto 0);
    signal inC : STD_LOGIC;
    signal Carry : STD_LOGIC_VECTOR(3 downto 0);
    signal Carry_reg : STD_LOGIC_VECTOR(3 downto 0);
    signal sum : STD_LOGIC_VECTOR(3 downto 0);
begin
    FA0 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA(0),
    inB(0),
    inC,
    Carry(0),
    sum(0)
);
FA1 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA(1),
    inB(1),
    Carry_reg(0),
    Carry(1),
    sum(1)
    );
FA2 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA(2),
    inB(2),
    Carry_reg(1),
    Carry(2),
    sum(2)
    );
FA3 : full_adder_seq_behav
 port map(
    clk,
    rst,
    inA(3),
    inB(3),
    Carry_reg(2),
    Carry(3),
    sum(3)
    );
    
    process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                inA <= (others => '0');
                inB <= (others => '0');
                Carry_reg <= (others => '0');
                inC <= '0';
                outputS <= (others => '0');
            else    
                outputS <= sum;
                inA <= inputA;
                inB <= inputB;
                inC <= Cin;
                Carry_reg <= Carry;
            end if;
        end if;
    end process;
    Cout <= Carry_reg(3);


end Behavioral;
