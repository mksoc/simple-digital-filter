LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY t_ff IS
	PORT (T, clock, sync_clr : IN STD_LOGIC;
		  Q                  : BUFFER STD_LOGIC);
END t_ff;

ARCHITECTURE structure OF t_ff IS
	
	SIGNAL D : STD_LOGIC;
	
	COMPONENT d_ff IS
		PORT (D, clock, sync_clr : IN STD_LOGIC;
			  Q                  : OUT STD_LOGIC );
	END COMPONENT;

BEGIN
	
	D <= T XOR Q;
	d_ff_0 : d_ff PORT MAP ( D => D, clock => clock, sync_clr => sync_clr, Q => Q );

END structure;