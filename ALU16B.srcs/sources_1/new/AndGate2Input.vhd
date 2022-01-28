library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AndGate2Input is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           z : out STD_LOGIC);
end AndGate2Input;

architecture Behavioral of AndGate2Input is

begin

z <= a AND b;

end Behavioral;