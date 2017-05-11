LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder IS
	PORT ( a, b, c_in : IN STD_LOGIC;
			 s, c_out   : OUT STD_LOGIC ) ;
END full_adder;

ARCHITECTURE behaviour OF full_adder IS

	SIGNAL prop, gen : STD_LOGIC;
	
BEGIN
	
		prop <= a XOR b;
		gen <= a AND b;
		s <= prop XOR c_in;
		c_out <= ( prop AND c_in ) OR gen;
		
END behaviour;