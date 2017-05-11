LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sync_count_base_block IS
	PORT ( En_prev, clock, sync_clr, async_rst : IN STD_LOGIC;
			 Q       : BUFFER STD_LOGIC;
			 En_next : OUT STD_LOGIC );
END sync_count_base_block;

ARCHITECTURE behaviour OF sync_count_base_block IS
	
	COMPONENT t_ff IS
	PORT ( T, clock, sync_clr, async_rst : IN STD_LOGIC;
			 Q : BUFFER STD_LOGIC );
	END COMPONENT;

BEGIN
	
	t_ff_0 : t_ff PORT MAP ( T => En_prev, clock => clock, sync_clr => sync_clr, async_rst => async_rst, Q => Q );
	
	En_next <= En_prev AND Q;

END ARCHITECTURE behaviour;