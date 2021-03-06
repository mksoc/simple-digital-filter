LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg IS
	GENERIC (N : INTEGER := 8);
	PORT (R                       : IN STD_LOGIC_VECTOR( N-1 DOWNTO 0 ); 
		  en_reg, clock, sync_clr : IN STD_LOGIC;
		  Q                       : BUFFER STD_LOGIC_VECTOR( N-1 DOWNTO 0 ));
END reg;

ARCHITECTURE behaviour OF reg IS
BEGIN
	PROCESS ( clock )
	BEGIN
        IF ( clock'EVENT AND clock = '1' ) THEN
                IF ( sync_clr = '0' ) THEN
                    IF ( en_reg = '1' ) THEN
                        Q <= R;
                    ELSE
                        Q <= Q;
                    END IF;
                ELSE
                    Q <= ( OTHERS => '0' );
                END IF;
        END IF;
	END PROCESS;
END behaviour;