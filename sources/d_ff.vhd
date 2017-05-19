LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY d_ff IS
	PORT (D, clock, sync_clr : IN STD_LOGIC;
	      Q                  : OUT STD_LOGIC);
END d_ff;

ARCHITECTURE behaviour OF d_ff IS
BEGIN
	PROCESS ( clock )
		BEGIN
			IF (clock'EVENT AND clock = '1') THEN
				IF ( sync_clr = '1' ) THEN
					Q <= '0';
				ELSE
					Q <= D;
				END IF;
            END IF;
		END PROCESS;
END behaviour;