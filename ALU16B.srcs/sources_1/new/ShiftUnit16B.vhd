library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftUnit16B is
    Port ( A,B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           Direction,Op_Type : in STD_LOGIC;
           ShiftOut : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end ShiftUnit16B;

architecture Behavioral of ShiftUnit16B is

begin

process(A, B, Direction, Op_Type)
    begin
                
        if(Direction = '0' and Op_Type = '0')then
            ShiftOut <= STD_LOGIC_VECTOR(unsigned(A) sll to_integer(unsigned(B)));
        elsif(Direction = '1' and Op_Type = '0')then
            ShiftOut <= STD_LOGIC_VECTOR(unsigned(A) srl to_integer(unsigned(B)));
        elsif(Direction = '0' and Op_Type = '1')then
            ShiftOut <= STD_LOGIC_VECTOR(unsigned(A) rol to_integer(unsigned(B)));
        elsif(Direction = '1' and Op_Type = '1')then 
            ShiftOut <= STD_LOGIC_VECTOR(unsigned(A) ror to_integer(unsigned(B)));
        else
            ShiftOut <= x"0000";
        end if;
    end process;
end Behavioral;