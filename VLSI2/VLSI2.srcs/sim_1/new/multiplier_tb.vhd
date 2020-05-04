library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_tb is
end entity;

architecture bench of multiplier_tb is 

    component multiplier is
        port (  clk,rst: in STD_LOGIC;
				a, b : in STD_LOGIC_VECTOR(3 downto 0);
				p : out STD_LOGIC_VECTOR(7 downto 0)
            );
    end component;
	
    signal             a :  STD_LOGIC_VECTOR (3 downto 0):= (others => '0');
    signal             b : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); 
    signal             p : STD_LOGIC_VECTOR (7 downto 0) ;
    signal             clk : STD_LOGIC;
    signal             rst : STD_LOGIC;    
    constant clock_period : time := 10ns;

begin

    uut : multiplier
        port map (
                   a => a,
                   b => b,
                   p => p,
                   clk =>clk,
                   rst => rst 
                    );

stimulus : process 
    begin
    rst <= '1';
    a  <= "0000";
    b  <= "0000";
    wait for clock_period*10 ;
    rst <= '0';
    for i in 0 to 15 loop
        a <= std_logic_vector(to_unsigned(i, 4));
        for j in 0 to 15 loop
            b <= std_logic_vector(to_unsigned(j, 4));
            wait for CLOCK_PERIOD*5;
        end loop;
    end loop;
    a <= "0000";
    b <= "0000";
    wait;
     
     
    end process;
    
    gen_clock : process
      begin 
            clk <= '1';
            wait for clock_period/2;
            clk <= '0';
            wait for clock_period/2;
       end process;
       
end architecture;  