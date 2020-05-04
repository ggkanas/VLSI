----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2020 11:17:22
-- Design Name: 
-- Module Name: pl_8tap_fir - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pl_8tap_fir is
  port (
    x : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    rst : in std_logic;
    valid_in : in std_logic;
    valid_out : out std_logic;
    y : out std_logic_vector(18 downto 0)
  );
end pl_8tap_fir;

architecture behavioral of pl_8tap_fir is
  type reg8 is array (0 to 7) of std_logic_vector(7 downto 0);
  signal xval : reg8 := (others => (others => '0'));
  
  type reg16_8 is array (0 to 7) of std_logic_vector(15 downto 0);
  signal plusreg_7 : reg16_8 := (others => (others => '0'));  

  type reg16_7 is array (0 to 6) of std_logic_vector(15 downto 0);
  signal plusreg_6 : reg16_7 := (others => (others => '0'));  

  type reg16_6 is array (0 to 5) of std_logic_vector(15 downto 0);
  signal plusreg_5 : reg16_6 := (others => (others => '0'));  

  type reg16_5 is array (0 to 4) of std_logic_vector(15 downto 0);
  signal plusreg_4 : reg16_5 := (others => (others => '0'));  

  type reg16_4 is array (0 to 3) of std_logic_vector(15 downto 0);
  signal plusreg_3 : reg16_4 := (others => (others => '0'));  

  type reg16_3 is array (0 to 2) of std_logic_vector(15 downto 0);
  signal plusreg_2 : reg16_3 := (others => (others => '0'));  

  type reg16_2 is array (0 to 1) of std_logic_vector(15 downto 0); 
  signal plusreg_1 : reg16_2 := (others => (others => '0'));  
  signal plusreg_0 : std_logic_vector(15 downto 0);

  signal xreg : reg16_8 := (others => (others => '0'));
  
  type reg19 is array (0 to 7) of std_logic_vector(18 downto 0);
  signal xreg_adder : reg19 := (others => (others => '0'));
  
  signal h : reg8 := (X"01",X"02",X"03",X"04",X"05",X"06",X"07",X"08"); 
  signal validate : std_logic := '0';
  
  begin
  
    xreg(7) <= xval(7) * h(0);
    xreg(6) <= xval(6) * h(1);
    xreg(5) <= xval(5) * h(2);
    xreg(4) <= xval(4) * h(3);
    xreg(3) <= xval(3) * h(4);
    xreg(2) <= xval(2) * h(5);
    xreg(1) <= xval(1) * h(6);
    xreg(0) <= xval(0) * h(7);

    valid_out <= validate;
  
    process(clk, rst) is 
      begin
        if rst = '1' then
          xval <= (others => (others => '0'));
          plusreg_0 <= (others => '0');
          plusreg_1 <= (others => (others => '0'));
          plusreg_2 <= (others => (others => '0'));
          plusreg_3 <= (others => (others => '0'));
          plusreg_4 <= (others => (others => '0'));
          plusreg_5 <= (others => (others => '0'));
          plusreg_6 <= (others => (others => '0'));
          plusreg_7 <= (others => (others => '0'));
          xreg_adder <= (others => (others => '0'));
          validate <= '0';         
        elsif rising_edge(clk) then  
            validate <= '0';
            for i in 0 to 6 loop
              xval(i) <= xval(i+1);
            end loop;
            xval(7) <= x;                 
            plusreg_0 <= plusreg_1(1);
            plusreg_1 <= (0 => plusreg_2(1), 1 => plusreg_2(2));
            plusreg_2 <= (0 => plusreg_3(1), 1 => plusreg_3(2), 2 => plusreg_3(3));
            plusreg_3 <= (0 => plusreg_4(1), 1 => plusreg_4(2), 2 => plusreg_4(3), 3 => plusreg_4(4));
            plusreg_4 <= (0 => plusreg_5(1), 1 => plusreg_5(2), 2 => plusreg_5(3), 3 => plusreg_5(4), 4 => plusreg_5(5));
            plusreg_5 <= (0 => plusreg_6(1), 1 => plusreg_6(2), 2 => plusreg_6(3), 3 => plusreg_6(4), 4 => plusreg_6(5), 5 => plusreg_6(6));
            plusreg_6 <= (0 => plusreg_7(1), 1 => plusreg_7(2), 2 => plusreg_7(3), 3 => plusreg_7(4), 4 => plusreg_7(5), 5 => plusreg_7(6), 6 => plusreg_7(7));
            plusreg_7 <= (0 => xreg(7), 1 => xreg(6), 2 => xreg(5), 3 => xreg(4), 4 => xreg(3), 5 => xreg(2), 6 => xreg(1), 7 => xreg(0));            
            
            xreg_adder(7) <= ("000" & plusreg_7(0));
            xreg_adder(6) <= ("000" & plusreg_6(0)) + xreg_adder(7);
            xreg_adder(5) <= ("000" & plusreg_5(0)) + xreg_adder(6);
            xreg_adder(4) <= ("000" & plusreg_4(0)) + xreg_adder(5);
            xreg_adder(3) <= ("000" & plusreg_3(0)) + xreg_adder(4);
            xreg_adder(2) <= ("000" & plusreg_2(0)) + xreg_adder(3);
            xreg_adder(1) <= ("000" & plusreg_1(0)) + xreg_adder(2);
            xreg_adder(0) <= ("000" & plusreg_0) + xreg_adder(1);
            if valid_in = '1' then 
              validate <= '1';
            end if;      
        end if;
    end process;
    y <= xreg_adder(0);
       
end behavioral;                                           
