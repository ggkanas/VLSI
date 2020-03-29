library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_seq is
    Port (clk : STD_LOGIC;
          rst : STD_LOGIC;
          inputA  : in STD_LOGIC;
          inputB  : in STD_LOGIC;
          Cin     : in STD_LOGIC;
          Cout    : out STD_LOGIC;
          outputS : out STD_LOGIC);
end full_adder_seq;