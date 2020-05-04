-- Unsigned Parallel Carry-Propagate Multiplier
--
-- p <= a * b;
--
library IEEE;
use IEEE.std_logic_1164.all;

entity multiplier is
	port
	(
		  clk,rst : in std_logic;
				a : in std_logic_vector(3 downto 0);
				b : in std_logic_vector(3 downto 0);
				p : out std_logic_vector(7 downto 0)

	);
end multiplier;

architecture structural of multiplier is

subtype a_word is std_logic_vector(3 downto 0);
type a_word_array is array(natural range <>) of a_word;
signal ai,ao,bi,bo,si,so,ci,co : a_word_array(3 downto 0);

signal cout_edge : std_logic_vector(2 downto 0);
signal cout_edge1 : std_logic_vector(2 downto 0);
signal cout_edge2 : std_logic_vector(2 downto 0);

signal a1 : std_logic_vector(1 downto 0);
signal a2 : std_logic_vector(2 downto 0);
signal a3 : std_logic_vector(3 downto 0);

signal b1 : std_logic_vector(1 downto 0);
signal b2 : std_logic_vector(4 downto 0);
signal b3 : std_logic_vector(6 downto 0);

signal p0 : std_logic_vector(10 downto 0);
signal p1 : std_logic_vector(7 downto 0);
signal p2 : std_logic_vector(5 downto 0);
signal p3 : std_logic_vector(3 downto 0);
signal p4 : std_logic_vector(2 downto 0);
signal p5 : std_logic_vector(1 downto 0);


component mul_cell is
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
end component;

begin
	-- cell generation
	gcb: for i in 0 to 3 generate
		gca: for j in 0 to 3 generate
			gc: mul_cell port map
				(
					ai => ai(i)(j),
					bi => bi(i)(j),
					si => si(i)(j),
					ci => ci(i)(j),
					clk => clk,
					rst => rst,
					ao => ao(i)(j),
					bo => bo(i)(j),
					so => so(i)(j),
					co => co(i)(j)
				);
		end generate;
	end generate;

-- intermediate wires generation
gasw: for i in 1 to 3 generate
			ai(i) <= ao(i-1);
			si(i) <= cout_edge(i-1) & so(i-1)(3 downto 1);  --correct for couts in edges
		end generate;
		
		
gbciw: for i in 0 to 3 generate
	gbcjw: for j in 1 to 3 generate
				bi(i)(j) <= bo(i)(j-1);
				ci(i)(j) <= co(i)(j-1);
			end generate;
		end generate;

-- input connections(input zeros ) 	
gsi: 	si(0) <= (others => '0');		

gci: 	for i in 0 to 3 generate
				ci(i)(0) <= '0';
			end generate;

process(clk)
	begin
		if clk'event and clk='1' then 
			if rst='1' then
			    cout_edge <= (others => '0');
			    cout_edge1 <= (others => '0');
			    cout_edge2 <= (others => '0');
				a1 <= (others => '0');
				a2 <= (others => '0');
				a3 <= (others => '0');
				b1 <= (others => '0');
				b2 <= (others => '0');
				b3 <= (others => '0');
				p0 <= (others => '0');
				p1 <= (others => '0');
				p2 <= (others => '0');
				p3 <= (others => '0');
				p4 <= (others => '0');
				p5 <= (others => '0');
				
			else 
			     
			    cout_edge2 <= (2 => co(2)(3) , 1 => co (1)(3), 0 => co(0)(3));
			    cout_edge1 <= cout_edge2;
			    cout_edge <= cout_edge1;
			    
				-- additional flipflops at b inputs
				b1(0) <= b(1);
				b1(1) <= b1(0);
				--b1(2) <= b1(1);
				
				b2(0) <= b(2);
				b2(1) <= b2(0);
				b2(2) <= b2(1);
				b2(3) <= b2(2);
				b2(4) <= b2(3);
				
				b3(0) <= b(3);
				b3(1) <= b3(0);
				b3(2) <= b3(1);
				b3(3) <= b3(2);
				b3(4) <= b3(3);
				b3(5) <= b3(4);
				b3(6) <= b3(5);
				
				-- additional flipflops at a inputs
			     a1 <= a(1 downto 0); --GG
			     --a1 <= a(1); 
			     --a1(1) <= a1(0);
			     
			     a2(0) <= a(2);
			     a2(1) <= a2(0);
			     a2(2) <= a2(1);
			     
			     a3(0) <= a(3);
			     a3(1) <= a3(0);
			     a3(2) <= a3(1);
			     a3(3) <= a3(2);
				
				-- additional flip flops at outputs
				p0(0) <= so(0)(0);
				p0(1) <= p0(0);
				p0(2) <= p0(1);
				p0(3) <= p0(2);
				p0(4) <= p0(3);
				p0(5) <= p0(4);
				p0(6) <= p0(5);
				p0(7) <= p0(6);
				p0(8) <= p0(7);
				p0(9) <= p0(8);
				p0(10) <= p0(9);
				
				p1(0) <= so(1)(0);
				p1(1) <= p1(0);
				p1(2) <= p1(1);
				p1(3) <= p1(2);
				p1(4) <= p1(3);
				p1(5) <= p1(4);
				p1(6) <= p1(5);
				p1(7) <= p1(6);
				
				p2(0) <= so(2)(0);
				p2(1) <= p2(0);
				p2(2) <= p2(1);
				p2(3) <= p2(2);
				p2(4) <= p2(3);
				p2(5) <= p2(4);
				
				p3(0) <= so(3)(0);
				p3(1) <= p3(0);
				p3(2) <= p3(1);
				p3(3) <= p3(2);
				
				p4(0) <= so(3)(1);
				p4(1) <= p4(0);
				p4(2) <= p4(1);
				
				p5(0) <= so(3)(2);
				p5(1) <= p5(0);
				
				       
			end if;
		end if;
				
			
	end process;
	     ai(0)(0) <= a(0);
	     ai(0)(1) <= a1(1);
         ai(0)(2) <= a2(2);
         ai(0)(3) <= a3(3);
         
         bi(0)(0) <= b(0);                  
         bi(1)(0) <= b1(1);
         bi(2)(0) <= b2(4);
         bi(3)(0) <= b3(6);    
               
	
	p <= co(3)(3) & so(3)(3) & p5(1) & p4(2) & p3(3) & p2(5) & p1(7) & p0(10);
end structural;