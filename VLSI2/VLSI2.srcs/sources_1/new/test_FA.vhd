library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity full_adder_seq_behav2 is
    Port (clk 	  : in STD_LOGIC;
          rst     : in STD_LOGIC;
          inputA  : in STD_LOGIC;
          inputB  : in STD_LOGIC;
          Cin     : in STD_LOGIC;
          Cout    : out STD_LOGIC;
          outputS : out STD_LOGIC);
end full_adder_seq_behav;

architecture FA_behavioral of full_adder_seq_behav2 is

    signal sum : STD_LOGIC_VECTOR(1 downto 0);
    --signal vect1 : STD_LOGIC;
    --signal vect2 : STD_LOGIC;
   -- signal vect3 : STD_LOGIC;
   -- signal inB   : STD_LOGIC;
   -- signal inC   : STD_LOGIC;

begin
    process(clk)
    begin
        if clk'event and clk='1' then
            if rst ='1' then
            
                sum <= (others => '0');
               -- inA <= '0';
               -- inB <= '0';
               -- inC <= '0';
               -- outputS <= '0';
               -- Cout <= '0';
            else
                sum <= ('0' & inputA) + ('0'& inputB) + ('0' & Cin);
                --inA <= inputA;
               -- inB <= inputB;
                --inC <= Cin;
                --vect1<=inA;
                --vect2<=inB;
                --vect3<=inC;
                
                --outputS <= sum(0);
                --Cout <= sum(1);
            end if;
        end if;
     --   vect1 <= (0 => inA);
      --  vect2 <= (0 => inB);
      --  vect3 <= (0 => inC);
      --  sum <= ('0' & inA) + ('0'& inB) + ('0' & inC);
        
    end process;
    
    outputS <= sum(0);
    Cout <= sum(1);
end FA_behavioral;