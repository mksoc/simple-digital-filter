LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY b9RCA IS
	PORT ( A, B            : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			 c_in            : IN STD_LOGIC;
			 S               : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			 c_out           : OUT STD_LOGIC ) ;
END b9RCA;

ARCHITECTURE behaviour OF b9RCA IS

	SIGNAL C_PROP : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	COMPONENT full_adder IS
		PORT ( a, b, c_in : IN STD_LOGIC;
				 s, c_out   : OUT STD_LOGIC );
	END COMPONENT;

BEGIN
	FA0 : full_adder PORT MAP ( a => A(0) , b => B(0), c_in => c_in, s => S(0), c_out => C_PROP(0) );
	FA1 : full_adder PORT MAP ( a => A(1) , b => B(1), c_in => C_PROP(0), s => S(1), c_out => C_PROP(1) );
	FA2 : full_adder PORT MAP ( a => A(2) , b => B(2), c_in => C_PROP(1), s => S(2), c_out => C_PROP(2) );
	FA3 : full_adder PORT MAP ( a => A(3) , b => B(3), c_in => C_PROP(2), s => S(3), c_out => C_PROP(3) );
	FA4 : full_adder PORT MAP ( a => A(4) , b => B(4), c_in => C_PROP(3), s => S(4), c_out => C_PROP(4) );
	FA5 : full_adder PORT MAP ( a => A(5) , b => B(5), c_in => C_PROP(4), s => S(5), c_out => C_PROP(5) );
	FA6 : full_adder PORT MAP ( a => A(6) , b => B(6), c_in => C_PROP(5), s => S(6), c_out => C_PROP(6) );
	FA7 : full_adder PORT MAP ( a => A(7) , b => B(7), c_in => C_PROP(6), s => S(7), c_out => C_PROP(7) );
	FA8 : full_adder PORT MAP ( a => A(8) , b => B(8), c_in => C_PROP(7), s => S(8), c_out => c_out );
END behaviour;
			 