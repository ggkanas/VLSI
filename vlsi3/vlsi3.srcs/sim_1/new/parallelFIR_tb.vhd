library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity parallelFIR_tb is
end parallelFIR_tb;

architecture testbench of parallelFIR_tb is
  component parallelFIR is
    port (
      clk : std_logic;
      rst : std_logic;
      x1 : in std_logic_vector(7 downto 0);
      x2 : in std_logic_vector(7 downto 0);
      y1 : out std_logic_vector(18 downto 0);
      y2 : out std_logic_vector(18 downto 0);
      valid_in : in std_logic;
      valid_out : out std_logic
    );
  end component;

  type regsN_8 is array(0 to 7) of std_logic_vector(7 downto 0);
  signal x1 : std_logic_vector(7 downto 0) := (others => '0');
  signal x2 : std_logic_vector(7 downto 0) := (others => '0');
  signal clk : std_logic;
  signal rst : std_logic;
  signal valid_in : std_logic;
  signal valid_out : std_logic;
  signal y1 : std_logic_vector(18 downto 0);
  signal y2 : std_logic_vector(18 downto 0);
  signal h : regsN_8 := (X"01",X"02",X"03",X"04",X"05",X"06",X"07",X"08");
  constant clk_period : time := 10 ns ;

  begin 
    uut : parallelFIR
    port map (
      clk,
      rst,
      x1,
      x2,
      y1,
      y2,
      valid_in,
      valid_out
    );   
    
    stimulus : process
      variable r : std_logic := '0';
      begin
        valid_in <= '0';
        rst <= '0';
        wait for clk_period*5;
        rst <= '1';
        wait for clk_period*5;
        rst <= '0';
        wait for clk_period*5;
        valid_in <= '1'; 
        for i in 0 to 7  loop
          x1 <= std_logic_vector(to_unsigned(2*i+1, 8));
          x2 <= std_logic_vector(to_unsigned(2*i+2, 8));
          wait for clk_period;
        end loop;
        x1 <= (others => '0');
        x2 <= (others => '0');
        valid_in <='0';
        wait for clk_period*10;
        valid_in <= '0';
        wait for clk_period*5;
        
        rst <= '1';
        wait for clk_period*5;
        rst <= '0';
        wait for clk_period*5;
        valid_in <= '1'; 
        for i in 0 to 7  loop
            x1 <= std_logic_vector(to_unsigned(2*i+1, 8));
            x2 <= std_logic_vector(to_unsigned(2*i+2, 8));
            wait for clk_period;
        end loop;
        x1 <= (others => '0');
        x2 <= (others => '0');
        valid_in <='0';
        wait;
    end process;
   
    clock_gen : process 
      begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process; 
  
end testbench;

