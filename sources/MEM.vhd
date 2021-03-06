LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY MEM IS
	GENERIC (N_addr : INTEGER := 10;
			 N_par  : INTEGER := 8); 
	PORT (clk, CS, RD, WR : IN STD_LOGIC;
	      ADDR : IN STD_LOGIC_VECTOR ( N_addr-1 DOWNTO 0 );
		  DATA_IN : IN STD_LOGIC_VECTOR ( N_par-1 DOWNTO 0 );
	      DATA_OUT : OUT STD_LOGIC_VECTOR ( N_par-1 DOWNTO 0 ));
END MEM;

ARCHITECTURE behaviour OF MEM IS

	TYPE CELLS_ARRAY IS ARRAY ( 0 TO 2**N_addr-1 ) OF STD_LOGIC_VECTOR ( N_par-1 DOWNTO 0 ); 
	SIGNAL CELL : CELLS_ARRAY;

BEGIN
   
	-- sync writing process
	wr_beh : PROCESS ( clk )
	BEGIN
		IF ( clk'EVENT AND clk = '1' ) THEN
			IF ( CS = '1' AND WR = '1' ) THEN
				CELL( TO_INTEGER(UNSIGNED((ADDR))) ) <= DATA_IN;
			END IF;
		END IF;
	END PROCESS;
	
	-- combinatorial reading
	rd_beh : PROCESS ( CS, RD, ADDR )
	BEGIN
		IF ( CS = '1' AND RD = '1' ) THEN
			DATA_OUT <= CELL( TO_INTEGER(UNSIGNED((ADDR))) );
		ELSE
			DATA_OUT <= "00000000"; -- if CS or RD are '0', DATA_OUT is "00000000"
		END IF;
	END PROCESS;

END ARCHITECTURE behaviour;