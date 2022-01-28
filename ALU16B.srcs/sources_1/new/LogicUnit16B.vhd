library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicUnit16B is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           OpCode : in STD_LOGIC_VECTOR(2 DOWNTO 0);
           LogicOut : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end LogicUnit16B;

architecture Behavioral of LogicUnit16B is
begin

p1: process(A,B,OpCode)
begin
    if(OpCode <= "000") then LogicOut <= not A or not B;--nor
    elsif(OpCode <= "001") then LogicOut <= not A and not B;--nand
    elsif(OpCode <= "010") then LogicOut <= A or B;--or
    elsif(OpCode <= "011") then LogicOut <= A and B;--and
    elsif(OpCode <= "100") then LogicOut <= (A and B) or (not A and not B);--xor
    elsif(OpCode <= "101") then LogicOut <= (A or B) and (not a or not B);--xnor
    elsif(OpCode <= "110") then LogicOut <= not A;--not A
    else LogicOut <= not B;--not B
    end if;
end process p1;

end Behavioral;
