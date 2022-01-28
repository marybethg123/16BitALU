library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controller is
    Port ( mode : in STD_LOGIC := '0';
           OpCode : in STD_LOGIC_VECTOR(2 DOWNTO 0):= "000";
           Sel0 : out STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";
           Sel1 : out STD_LOGIC;
           Sel_Cout : out STD_LOGIC;
           Sel2 : out STD_LOGIC;
           di : out STD_LOGIC := '0';
           ty : out STD_LOGIC := '0');
end Controller;

architecture Behavioral of Controller is

begin
p1: process(mode, OpCode)
begin

    if(mode <= '0')then --we want the Logic unit to do something
        --arbitrary: then OpCode <= OpCode;
        Sel1 <= '0'; --we dont care about mux1
        Sel_Cout <= '0'; --only matters for arithmatic unit
        Sel2 <= '1'; --1 is the right most arrow to mux2
    else
        if std_match(OpCode, "0--")then --we want the Arithmatic unit to do something
            Sel0 <= OpCode (1 DOWNTO 0);
            Sel_Cout <= '1'; --only matters for arithmatic unit
            Sel1 <= '0'; --0 is left most arrow to mux1 (for arithmatic)
            Sel2 <= '0'; --0 is the left most arrow from mux1 to mux2
            
        elsif std_match(OpCode, "1--") then --we want the Shift unit to do something
            di <= OpCode(0); --LSB is direction (1-di)
            ty <= OpCode(1); --next LSB is type (1ty-)
			Sel_Cout <= '0'; --only matters for arithmatic unit
            Sel1 <= '1'; --1 is right most arrow to mux1 (for shifter)
            Sel2 <= '0'; --0 is the left most arrow from mux1 to mux2
        end if;
    end if;
end process;
end Behavioral;
