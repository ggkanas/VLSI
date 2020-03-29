

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity half_adder is
    Port (inputA  : in  STD_LOGIC;
          inputB  : in  STD_LOGIC;
          outputS : out STD_LOGIC;
          outputC : out STD_LOGIC);
end half_adder;

architecture HA_dataflow of half_adder is

begin
    outputS <= inputA xor inputB;
    outputC <= inputA and inputB;
end HA_dataflow;
