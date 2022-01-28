library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ArithmeticUnit16B is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           Op_Sel : in STD_LOGIC_VECTOR(1 DOWNTO 0);
           ArithOut : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           Cout : out STD_LOGIC);
end ArithmeticUnit16B;

architecture Behavioral of ArithmeticUnit16B is

begin

process(Op_Sel,A,B)

variable temp: STD_LOGIC_VECTOR(15 DOWNTO 0);

    begin
                
        if (Op_Sel = "00") then 
            temp := STD_LOGIC_VECTOR(unsigned(A(7 downto 0)) * unsigned(B(7 downto 0)));
            ArithOut <= temp;--A*B
            if(temp /= "000000000000--------")then
                Cout <= '0';
            else
                Cout <= '1';
            end if;
        elsif (Op_sel = "01") then 
            temp := STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));--A+B
            ArithOut <= temp;
            if(temp = x"0000")then
                Cout <= '1';
            else
                Cout <= '0';
            end if;
        elsif (Op_Sel = "10") then 
            ArithOut <= STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));--A-B
            Cout <= '0';
        elsif (Op_Sel = "11") then 
            ArithOut <= STD_LOGIC_VECTOR(unsigned(A) + x"0001");--incriment A
            if(A = x"FFFF")then
                Cout <= '1';
            else
                Cout <= '0';
            end if;
        else 
            ArithOut <= (x"0000");
        end if;
        
    end process;
end Behavioral;