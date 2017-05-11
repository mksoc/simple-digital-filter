LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY b9_2to1MUX IS
PORT ( in_0, in_1 : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		 sel        : IN STD_LOGIC;
		 output     : OUT STD_LOGIC_VECTOR (8 DOWNTO 0) );
END b9_2to1MUX;

ARCHITECTURE behaviour OF b9_2to1MUX IS
BEGIN

	output <= in_0 WHEN sel = '0' ELSE
				 in_1 WHEN sel = '1';
	
END behaviour;