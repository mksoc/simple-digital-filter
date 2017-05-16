LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DP IS
	PORT (clk, sync_clr                              : IN STD_LOGIC;
		  DATA_OUT_A                                 : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
	      en_reg_0, en_reg_1, en_reg_2, en_reg_S     : IN STD_LOGIC;
	  	  clr_reg_0, clr_reg_1, clr_reg_2, clr_reg_S : IN STD_LOGIC;
	      en_cnt, clr_cnt, sel_mux_0, sub_0, sub_1   : IN STD_LOGIC;
		  sel_mux_1, sel_mux_wr                      : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		  sat_pos, sat_neg, cnt_0, TC				 : OUT STD_LOGIC; 
		  ADDR_A, ADDR_B                             : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
		  DATA_IN_B                                  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END DP;

ARCHITECTURE structure OF DP IS

	SIGNAL reg_0_D, reg_1_D, reg_2_D, reg_0_Q, reg_1_Q, reg_2_Q : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL X_2, X_05, X_025, X, out_mux_0, out_mux_1, add_0, 
			add_1, reg_S_D, reg_S_Q : STD_LOGIC_VECTOR (8 DOWNTO 0);
	SIGNAL cnt : STD_LOGIC_VECTOR (9 DOWNTO 0);
	SIGNAL sub, c_out, ovflw, ovflw_sat_neg, ovflw_sat_pos, end_sat_pos, 
			end_sat_neg, b9_ovflw, end_sat, boh : STD_LOGIC;

	COMPONENT b10_sync_count IS
		GENERIC (N : integer := 10);
		PORT (en_cnt, clock, sync_clr  : IN STD_LOGIC;
			  cnt                      : BUFFER STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			  TC                       : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT b9RCA IS
		PORT (A, B            : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			  c_in            : IN STD_LOGIC;
			  S               : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			  c_out           : OUT STD_LOGIC ) ;
	END COMPONENT;

	COMPONENT reg IS
		GENERIC (N : INTEGER := 8);
		PORT (R                       : IN STD_LOGIC_VECTOR( N-1 DOWNTO 0 ); 
			  en_reg, clock, sync_clr : IN STD_LOGIC;
			  Q                       : OUT STD_LOGIC_VECTOR( N-1 DOWNTO 0 ));
	END COMPONENT;
	
	COMPONENT b9_2to1MUX IS
		PORT (in_0, in_1 : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
			  sel        : IN STD_LOGIC;
			  output     : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT b9_4to1mux IS
	PORT (in_00, in_01, in_10, in_11 : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		  sel                        : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		  output                     : OUT STD_LOGIC_VECTOR (8 DOWNTO 0));
	END COMPONENT;
		
	COMPONENT b8_4to1mux IS
		PORT (in_00, in_01, in_10, in_11 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			  sel                        : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			  output                     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;

BEGIN

	reg_0_D <= DATA_OUT_A;
	reg_1_D <= reg_0_Q;
	reg_2_D <= reg_1_Q;

	reg_0 : reg PORT MAP ( en_reg => en_reg_0, R => reg_0_D, clock => clk, sync_clr => clr_reg_0, Q => reg_0_Q );
	reg_1 : reg PORT MAP ( en_reg => en_reg_1, R => reg_1_D, clock => clk, sync_clr => clr_reg_1, Q => reg_1_Q );
	reg_2 : reg PORT MAP ( en_reg => en_reg_2, R => reg_2_D, clock => clk, sync_clr => clr_reg_2, Q => reg_2_Q );
	
	X_05 <= DATA_OUT_A(7) & DATA_OUT_A(7) & DATA_OUT_A(7 DOWNTO 1);
	X_2 <= reg_0_Q & '0';
	X <= reg_1_Q(7) & reg_1_Q;
	X_025 <= reg_2_Q(7) & reg_2_Q(7) & reg_2_Q(7) & reg_2_Q(7 DOWNTO 2);
	
	mux_0 : b9_2to1MUX PORT MAP ( in_0 => X_2, in_1 => reg_S_Q, sel => sel_mux_0, output => out_mux_0 );
	mux_1 : b9_4to1mux PORT MAP ( in_00 => X, in_01 => X_025, in_10 => X_05, in_11 => "000000000", sel => sel_mux_1, output => out_mux_1 );
	
	invert_add : FOR i IN 8 DOWNTO 0 GENERATE
		add_0(i) <= out_mux_0(i) XOR sub_0;
		add_1(i) <= out_mux_1(i) XOR sub_1;
	END GENERATE;
	
	sub <= sub_0 OR sub_1;
	
	adder : b9RCA PORT MAP ( A => add_0, B => add_1, c_in => sub, S => reg_S_D, c_out => c_out );
	
	ovflw <= c_out XOR reg_S_D(8) XOR add_0(8) XOR add_1(8);
	
	ovflw_sat_pos <= NOT add_0(8) AND ovflw;
	ovflw_sat_neg <= add_0(8) AND ovflw;
	
	b9_ovflw <= reg_S_D(7) XOR reg_S_D(8);
    boh <= sel_mux_1(0) and (not ovflw);
	end_sat <= b9_ovflw AND boh;
	end_sat_pos <= end_sat AND NOT reg_S_D(8);
	end_sat_neg <= end_sat AND reg_S_D(8);
	
	sat_pos <= ovflw_sat_pos OR end_sat_pos;
	sat_neg <= ovflw_sat_neg OR end_sat_neg;
	
	reg_S : reg GENERIC MAP ( N => 9 )
					PORT MAP ( en_reg => en_reg_S, R => reg_S_D, clock => clk, sync_clr => clr_reg_S, Q => reg_S_Q );
	
	mux_wr : b8_4to1mux PORT MAP ( in_00 => reg_S_Q (7 DOWNTO 0), in_01 => "01111111", in_10 => "10000000", in_11 => "00000000", sel => sel_mux_wr, output => DATA_IN_B );
							  						  
	counter : b10_sync_count PORT MAP ( en_cnt => en_cnt, clock => clk, sync_clr => clr_cnt, cnt => cnt, TC => TC );
	
	cnt_0 <= cnt(0);
	
	ADDR_A <= cnt;
	ADDR_B <= cnt;
	
END ARCHITECTURE structure;