----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2020 11:21:08
-- Design Name: 
-- Module Name: pl_8tap_fir_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pl_8tap_fir_tb is
end pl_8tap_fir_tb;

architecture testbench of pl_8tap_fir_tb is
  component pl_8tap_fir is
    port (
      x : in std_logic_vector(7 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      valid_in : in std_logic;
      valid_out : out std_logic;
      y : out std_logic_vector(18 downto 0)
    );
  end component;

  signal x : std_logic_vector(7 downto 0) := (others => '0');
  signal clk : std_logic;
  signal rst : std_logic;
  signal valid_in : std_logic;
  signal valid_out : std_logic;
  signal y : std_logic_vector(18 downto 0);
  constant wait_period : time := 10 ns ;

  begin 
    uut : pl_8tap_fir
    port map (
      x => x,
      clk => clk,
      rst => rst,
      valid_in => valid_in,
      valid_out => valid_out,
      y => y
    );   
    
    valid_in <= '1';

    stimulus : process
      variable r : std_logic := '0';
      begin
        rst <= '0';
        wait for wait_period*5;
        rst <= '1';
        wait for wait_period*5;
        rst <= '0';
        wait for wait_period*5; 
        for i in 1 to 15 loop
          x <= std_logic_vector(to_unsigned(i, 8));
          wait for wait_period;
        end loop;
        x <= (others => '0');
        wait;
    end process;
   
    clock_gen : process 
      begin
        clk <= '1';
        wait for wait_period/2;
        clk <= '0';
        wait for wait_period/2;
    end process; 
  
end testbench;
