library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declares Inpus/Outputs for the Entity --
entity MUX2_1 is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           sel : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end MUX2_1;
-- End Entity Declarations --

-- Behavioral Implimentqation of Entity --
architecture Behavioral of MUX2_1 is
begin

process(A,B,sel)
begin
    z <= A;
	if sel = '1' then z <= B;
	end if;
end process;

end Behavioral;
-- End Behavioral Implementation --