LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY b10_sync_count IS
	GENERIC ( N : integer := 10 );
	PORT ( en_cnt, clock, sync_clr, async_rst : IN STD_LOGIC;
	       cnt                     			   : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			 TC                                 : OUT STD_LOGIC );
END b10_sync_count;

ARCHITECTURE behaviour OF b10_sync_count IS

	SIGNAL En_prev_to_next : STD_LOGIC_VECTOR(0 TO N-2);

	COMPONENT sync_count_base_block IS
		PORT ( en_prev, clock, sync_clr, async_rst : IN STD_LOGIC;
				 Q                       					  : BUFFER STD_LOGIC;
				 En_next                					  : OUT STD_LOGIC );
	END COMPONENT;

BEGIN

	t_ff_gen : FOR i IN 0 TO N-1 GENERATE
		
		LSB : IF i=0 GENERATE
			sc_bb_LSB : sync_count_base_block PORT MAP ( En_prev => en_cnt, clock => clock, sync_clr => sync_clr, async_rst => async_rst, Q => cnt(i), En_next => En_prev_to_next(i) );
		END GENERATE LSB;
				
		OTHER_BITS : IF i>0 AND i<N-1 GENERATE
			sc_bb_i : sync_count_base_block PORT MAP ( En_prev => En_prev_to_next(i-1), clock => clock, sync_clr => sync_clr, async_rst => async_rst, Q => cnt(i), En_next => En_prev_to_next(i) );
		END GENERATE OTHER_BITS;
			
		MSB : IF i=N-1 GENERATE
			sc_bb_i : sync_count_base_block PORT MAP ( En_prev => En_prev_to_next(i-1), clock => clock, sync_clr => sync_clr, async_rst => async_rst, Q => cnt(i) );
		END GENERATE MSB;
					
	END GENERATE t_ff_gen;
	
	TC <= '1' WHEN cnt = "1111111111" ELSE
			'0';
		
END ARCHITECTURE behaviour;