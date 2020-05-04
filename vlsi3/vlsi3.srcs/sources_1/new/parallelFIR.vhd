library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity parallelFIR is
    generic (
      N : integer := 8
    );
    port ( 
      clk : std_logic;
      rst : std_logic;
      x1  : in std_logic_vector(N-1 downto 0);
      x2  : in std_logic_vector(N-1 downto 0);
      y1  : out std_logic_vector(2*N+2 downto 0);
      y2  : out std_logic_vector(2*N+2 downto 0);
      valid_in  : in std_logic;
      valid_out : out std_logic
    );
end parallelFIR;

architecture Behavioral of parallelFIR is
  type regsN is array (0 to 8) of std_logic_vector(N-1 downto 0);
  type regsN_8 is array (0 to 7) of std_logic_vector(N-1 downto 0);
  type regs2N is array (0 to 8) of std_logic_vector(2*N-1 downto 0);
  type regsL is array (0 to 8) of std_logic_vector(2*N+2 downto 0);
  subtype reg2N is std_logic_vector(2*N-1 downto 0);
  type regs2 is array (0 to 1) of reg2N;
  type regs3 is array (0 to 2) of reg2N;
  type bit9 is array (0 to 8) of std_logic;  
  
  constant h : regsN_8 := (X"01",X"02",X"03",X"04",X"05",X"06",X"07",X"08");  --("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", 
                            --"00000010", "00000001"); 
  signal xval : regsN  := (others => (others => '0'));
  signal mult1 : regs2N := (others => (others => '0'));
   signal mult2 : regs2N := (others => (others => '0'));
  signal add  : regsL  := (others => (others => '0'));
  signal mbuffer2 : reg2N := (others => '0');
  signal mbuffer3 : reg2N := (others => '0');
  signal mbuffer4 : regs2 := (others => (others => '0'));
  signal mbuffer5 : regs2 := (others => (others => '0'));
  signal mbuffer6 : regs3 := (others => (others => '0'));
  signal mbuffer7 : regs3 := (others => (others => '0'));
  --signal mbuffer8 : regs3 := (others => (others => '0'));
  
  signal mbuffer3_2 : reg2N := (others => '0');
  signal mbuffer4_2 : reg2N := (others => '0');
  signal mbuffer5_2 : regs2 := (others => (others => '0'));
  signal mbuffer6_2 : regs2 := (others => (others => '0'));
  signal mbuffer7_2 : regs3 := (others => (others => '0'));
  signal mbuffer8_2 : regs3 := (others => (others => '0'));
  signal validate : std_logic_vector(8 downto 0);
  
begin

    process(clk, rst) is
    begin
        if rst = '1' then
            xval <= (others => (others => '0'));
            mult1 <= (others => (others => '0'));
            mult2 <= (others => (others => '0'));
            add <= (others => (others => '0'));
            mbuffer2 <= (others => '0');
            mbuffer3 <= (others => '0');
            mbuffer4 <= (others => (others => '0'));
            mbuffer5 <= (others => (others => '0'));
            mbuffer6 <= (others => (others => '0'));
            mbuffer7 <= (others => (others => '0'));
            
            mbuffer3_2 <= (others => '0');
            mbuffer4_2 <= (others => '0');
            mbuffer5_2 <= (others => (others => '0'));
            mbuffer6_2 <= (others => (others => '0'));
            mbuffer7_2 <= (others => (others => '0'));
            mbuffer8_2 <= (others => (others => '0'));
            validate <= (others => '0');        
        elsif rising_edge(clk) then
          if valid_in = '1' then
            for i in 8 downto 2 loop
                xval(i) <= xval(i-2);
            end loop;
            
            mbuffer2 <= mult1(2);
            mbuffer3 <= mult1(3);
            mbuffer3_2 <= mult2(3);
            mbuffer4(1) <= mbuffer4(0);
            mbuffer4(0) <= mult1(4);
            mbuffer4_2 <= mult2(4);
            mbuffer5(1) <= mbuffer5(0);
            mbuffer5(0) <= mult1(5);
            mbuffer5_2(1) <= mbuffer5_2(0);
            mbuffer5_2(0) <= mult2(5);
            mbuffer6_2(1) <= mbuffer6_2(0);
            mbuffer6_2(0) <= mult2(6);
            for i in 2 downto 1 loop
                mbuffer6(i) <= mbuffer6(i-1);
                mbuffer7(i) <= mbuffer7(i-1);
                mbuffer7_2(i) <= mbuffer7_2(i-1);
                mbuffer8_2(i) <= mbuffer8_2(i-1);
            end loop;
            mbuffer6(0) <= mult1(6);
            mbuffer7(0) <= mult1(7);
            mbuffer7_2(0) <= mult2(7);
            mbuffer8_2(0) <= mult2(8);
            
            for i in 0 to 7 loop
                mult1(i) <= xval(i) * h(i);
                mult2(i+1) <= xval(i+1) * h(i);
            end loop;
            
            add(0) <= ("000" & mult1(0)) + ("000" & mult1(1));
            add(1) <= ("000" & mult2(1)) + ("000" & mult2(2));
            add(2) <= ("000" & mbuffer2) + ("000" & mbuffer3) + add(0);
            add(3) <= ("000" & mbuffer3_2) + ("000" & mbuffer4_2) + add(1);
            add(4) <= ("000" & mbuffer4(1)) + ("000" & mbuffer5(1)) + add(2);
            add(5) <= ("000" & mbuffer5_2(1)) + ("000" & mbuffer6_2(1)) + add(3);
            add(6) <= ("000" & mbuffer6(2)) + ("000" & mbuffer7(2)) + add(4);
            add(7) <= ("000" & mbuffer7_2(2)) + ("000" & mbuffer8_2(2)) + add(5);
            
            for i in 8 downto 1 loop
                validate(i) <= validate(i-1);
            end loop;
            validate(0) <= valid_in;
          end if;
        end if;
        xval(0) <= x2;
        xval(1) <= x1;       
    
    end process; 
    y2 <= add(6);
    y1 <= add(7);
    valid_out <= validate(8) and valid_in;
    


end Behavioral;
