LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY b9_4to1mux IS
	PORT ( in_00, in_01, in_10, in_11 : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			 sel                        : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			 output                     : OUT STD_LOGIC_VECTOR (8 DOWNTO 0) );
END b9_4to1mux;

ARCHITECTURE behaviour OF b9_4to1mux IS

BEGIN
	
	output <= in_00 WHEN sel = "00" ELSE
				 in_01 WHEN sel = "01" ELSE
				 in_10 WHEN sel = "10" ELSE
				 in_11;

END behaviour;