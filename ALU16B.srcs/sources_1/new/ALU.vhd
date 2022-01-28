library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           mode: in STD_LOGIC;
           OpCode: in STD_LOGIC_VECTOR(2 DOWNTO 0);
           ALU_Out: out STD_LOGIC_VECTOR(15 DOWNTO 0);
           ALU_Cout: out STD_LOGIC);
end ALU;


architecture Behavioral of ALU is
--Controller--
component Controller is
    Port ( mode : in STD_LOGIC;
           OpCode : in STD_LOGIC_VECTOR(2 DOWNTO 0):= "000";
           Sel0 : out STD_LOGIC_VECTOR(1 DOWNTO 0):= "00";
           Sel1 : out STD_LOGIC;
           Sel_Cout : out STD_LOGIC;
           Sel2 : out STD_LOGIC;
           di : out STD_LOGIC := '0';
           ty : out STD_LOGIC := '0');
end component;

--Arithmetic Unit--
component ArithmeticUnit16B is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           Op_Sel : in STD_LOGIC_VECTOR(1 DOWNTO 0);
           ArithOut : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           Cout : out STD_LOGIC);
end component;

--Shifter Unit--
component ShiftUnit16B is
    Port ( A,B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           Direction,Op_Type : in STD_LOGIC;
           ShiftOut : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

--Logic Unit--
component LogicUnit16B is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           OpCode : in STD_LOGIC_VECTOR(2 DOWNTO 0);
           LogicOut : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

--2-1 MUX--
component MUX2_1 is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           sel : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

--2 input AND--
component AndGate2Input is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           z : out STD_LOGIC);
end component;

--Controller Outputs--
signal Sel0: STD_LOGIC_VECTOR(1 DOWNTO 0);
signal Sel1: STD_LOGIC;
signal Sel_Cout: STD_LOGIC;
signal Sel2: STD_LOGIC;
signal di: STD_LOGIC;
signal ty: STD_LOGIC;

--Arithmetic Outputs--
signal ArithOut: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal Cout: STD_LOGIC;

--Shifer Outputs--
signal ShiftOut: STD_LOGIC_VECTOR(15 DOWNTO 0);

--Logic Outputs--
signal LogicOut : STD_LOGIC_VECTOR(15 DOWNTO 0);

--MUX outputs--
signal z : STD_LOGIC_VECTOR(15 DOWNTO 0);

begin

control: Controller PORT MAP (
    mode => mode, 
    OpCode => OpCode, 
    Sel0 => Sel0,
    Sel1 => Sel1,
    Sel_Cout => Sel_Cout,
    Sel2 => Sel2,
    di => di,
    ty => ty);
    
arithmatic: ArithmeticUnit16B PORT MAP (
    A => A,
    B => B,
    Op_Sel => Sel0,
    ArithOut => ArithOut,
    Cout => Cout);

shift: ShiftUnit16B PORT MAP(
    A => A,
    B => B,
    Direction => di,
    Op_Type => ty,
    ShiftOut => ShiftOut);

logic: LogicUnit16B PORT MAP(
    A => A,
    B => B,
    OpCode => OpCode,
    LogicOut => LogicOut);
    
MUX1: MUX2_1 PORT MAP(
    A => ArithOut,
    B => ShiftOut, 
    sel => Sel1,
    z => z);

MUX2: MUX2_1 PORT MAP(
    A => z,
    B => LogicOut, 
    sel => Sel2,
    z => ALU_Out);
    
ANDGate: AndGate2Input PORT MAP(
    a => Sel_Cout,
    b => Cout,
    z => ALU_Cout);

end Behavioral;
