library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

component ALU is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           mode: in STD_LOGIC;
           OpCode: in STD_LOGIC_VECTOR(2 DOWNTO 0);
           ALU_Out: out STD_LOGIC_VECTOR(15 DOWNTO 0);
           ALU_Cout: out STD_LOGIC);
end component;

signal A : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal B : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal mode: STD_LOGIC;
signal OpCode: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal ALU_Out: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ALU_Cout: STD_LOGIC;

begin

utt: ALU PORT MAP(A => A, B => B, mode => mode, OpCode => OpCode, ALU_Out => ALU_Out, ALU_Cout => ALU_Cout);

process
begin
    --logic--
    ---------
    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "000";--nor
    --should return ffff
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "001";--nand
    --should return fffc
    wait for 40 ns;

    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "010";--or
    --should return 0003
    wait for 40 ns;

    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "011";--and
    --should return 0000
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "100";--xor
    --should return fffc
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "101";--xnor
    --should return 0003
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "110";--not A
    --should return fffe
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0002";
    mode <= '0';
    OpCode <= "111";--not B
    --should return fffd
    wait for 40 ns;
   
   --arithmetic-- 
   --------------
    A <= x"0001";
    B <= x"0001";
    mode <= '1';
    OpCode <= "000";--A*B
    --should return 0001
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"FFFF";
    mode <= '1';
    OpCode <= "001";--A+B
    --should return 0000 and a carry
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0001";
    mode <= '1';
    OpCode <= "001";--A+B
    --should return 0002
    wait for 40 ns;
    
    A <= x"0001";
    B <= x"0001";
    mode <= '1';
    OpCode <= "010";--A-B
    --should return 0000
    wait for 40 ns;
    
    A <= x"FFFF";
    B <= x"0000";
    mode <= '1';
    OpCode <= "011";--Incriment A
    --should return 0000 and a carry
    wait for 40 ns;
   
   A <= x"0001";
    B <= x"0001";
    mode <= '1';
    OpCode <= "001";--A+B
    --should return 0002
    wait for 40 ns;
    
    A <= x"FFFF";
    B <= x"0000";
    mode <= '1';
    OpCode <= "011";--Incriment A
    --should return 0000 and a carry
    wait for 40 ns;
    
    A <= x"0000";
    B <= x"0000";
    mode <= '1';
    OpCode <= "011";--Incriment A
    --should return 0001
    wait for 40 ns;
    
    --shift--
    ---------
    A <= x"FFFA";
    B <= x"0001";
    mode <= '1';
    OpCode <= "100";--lsl
    --should return fffa
    wait for 40 ns;
    
    A <= x"FFFA";
    B <= x"0001";
    mode <= '1';
    OpCode <= "101";--lsr
    --should return 7ffd
    wait for 40 ns;
    
    A <= x"FFFA";
    B <= x"0001";
    mode <= '1';
    OpCode <= "110";--rol
    --should return fff5
    wait for 40 ns;
    
    A <= x"FFFA";
    B <= x"0001";
    mode <= '1';
    OpCode <= "111";--ror
    --should return fff4
    wait; 
end process;
end Behavioral;