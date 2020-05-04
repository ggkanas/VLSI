-- Multiplier cell
--
-- (co,so) <= (a*b) + si + ci
-- (ao,bo) <= (ai,bi)
--
library IEEE;
use IEEE.std_logic_1164.all;

entity mul_cell is
	port
	(
		ai : in std_logic;
		bi : in std_logic;
		si : in std_logic;
		ci : in std_logic;
		clk : in std_logic;
		rst : in std_logic;
		ao : out std_logic;
		bo : out std_logic;
		so : out std_logic;
		co : out std_logic
	);
end mul_cell;

architecture structural of mul_cell is

component full_adder_seq_behav is
	 Port (clk 	  : in STD_LOGIC;
          rst     : in STD_LOGIC;
          inputA  : in STD_LOGIC;
          inputB  : in STD_LOGIC;
          Cin     : in STD_LOGIC;
          Cout    : out STD_LOGIC;
          outputS : out STD_LOGIC);
end component;



signal ab  :	std_logic;
signal s   :    std_logic;
signal s1  :    std_logic;
signal a   :    std_logic;
signal b   :    std_logic;
signal c   :    std_logic;
signal b1  :    std_logic;
signal a1  :    std_logic;
signal a2  :    std_logic;


begin
	
	FA : full_adder_seq_behav
	PORT MAP (clk =>clk,
	          rst =>rst,
	          inputA => s,
			  inputB =>ab,
			  Cin => c,
			  Cout => co,
			  outputS =>so);
	 
	
	process(clk)
    begin
        if clk'event and clk='1' then
			if rst ='1' then
			
				ab <= '0';
				s   <= '0';
				
				a  <= '0';
				a1 <= '0';
				a2 <= '0';
				b  <= '0';
				b1 <= '0';
				c  <= '0';
			else
			    ab <= ai and bi; 
			    s  <= si;
				a <= ai;
				a1 <= a;
				a2 <= a1;
				b <= bi;
				b1 <= b; 
				c <= ci;
				
			end if;
		end if;

	end process;
	ao <= a2;
	bo <= b1;
	
end structural;	
		