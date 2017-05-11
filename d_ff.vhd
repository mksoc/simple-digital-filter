LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY d_ff IS
	PORT ( D, clock, sync_clr, async_rst : IN STD_LOGIC;
			 Q                             : OUT STD_LOGIC );
END d_ff;

ARCHITECTURE behaviour OF d_ff IS
BEGIN
	PROCESS ( clock, async_rst )
		BEGIN
			IF (async_rst = '1') THEN
				Q <= '0';
			ELSIF (clock'EVENT AND clock = '1') THEN
				IF ( sync_clr = '1' ) THEN
					Q <= '0';
				ELSE
					Q <= D;
				END IF;
			END IF;
		END PROCESS;
END behaviour;