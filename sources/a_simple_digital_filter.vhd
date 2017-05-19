LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- this is the top level entity, the user can see only these inputs/outputs

ENTITY a_simple_digital_filter IS
	PORT (DATA_IN                         : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- data to write on MEM_A
		  START, clk, async_rst           : IN STD_LOGIC;
		  DONE                            : OUT STD_LOGIC;
          WR_B_ext                        : OUT STD_LOGIC; -- only for debugging purposes
          DATA_IN_B_ext                   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)); -- only for debugging purposes
END a_simple_digital_filter;

ARCHITECTURE structure OF a_simple_digital_filter IS
    -- signal declarations
	SIGNAL CS_A, RD_A, WR_A, CS_B, RD_B, WR_B            : STD_LOGIC;
	SIGNAL ADDR_A, ADDR_B                                : STD_LOGIC_VECTOR (9 DOWNTO 0);
	SIGNAL DATA_OUT_A, DATA_IN_B                         : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL cnt_0, TC, sat_pos, sat_neg                   : STD_LOGIC;
	SIGNAL en_reg_0, en_reg_1, en_reg_2, en_reg_S        : STD_LOGIC;
	SIGNAL clr_reg_0, clr_reg_1, clr_reg_2, clr_reg_S    : STD_LOGIC;
	SIGNAL en_cnt, clr_cnt, sel_mux_0, sub_0, sub_1      : STD_LOGIC;
	SIGNAL sel_mux_1, sel_mux_wr                         : STD_LOGIC_VECTOR (1 DOWNTO 0);

    -- component declarations
	COMPONENT CU IS
		PORT (clk, async_rst, start                      : IN STD_LOGIC;
			  cnt_0, TC, sat_pos, sat_neg                : IN STD_LOGIC; 
			  CS_A, RD_A, WR_A, CS_B, RD_B, WR_B         : OUT STD_LOGIC;
			  en_reg_0, en_reg_1, en_reg_2, en_reg_S     : OUT STD_LOGIC; 
			  clr_reg_0, clr_reg_1, clr_reg_2, clr_reg_S : OUT STD_LOGIC;
			  en_cnt, clr_cnt, sel_mux_0, sub_0, sub_1   : OUT STD_LOGIC;
			  sel_mux_1, sel_mux_wr                      : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			  done                                       : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT DP IS
		PORT (clk                                        : IN STD_LOGIC;
			  DATA_OUT_A                                 : IN STD_LOGIC_VECTOR (7 DOWNTO 0); 
			  en_reg_0, en_reg_1, en_reg_2, en_reg_S     : IN STD_LOGIC;
			  clr_reg_0, clr_reg_1, clr_reg_2, clr_reg_S : IN STD_LOGIC;
			  en_cnt, clr_cnt, sel_mux_0, sub_0, sub_1   : IN STD_LOGIC;
			  sel_mux_1, sel_mux_wr                      : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			  sat_pos, sat_neg, cnt_0, TC				 : OUT STD_LOGIC; 
			  ADDR_A, ADDR_B                             : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
			  DATA_IN_B                                  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;

	COMPONENT MEM IS
		GENERIC (N_addr : INTEGER := 10;
				   N_par  : INTEGER := 8 ); 
		PORT (clk, CS, RD, WR : IN STD_LOGIC;
			   ADDR            : IN STD_LOGIC_VECTOR ( N_addr-1 DOWNTO 0 );
			   DATA_IN         : IN STD_LOGIC_VECTOR ( N_par-1 DOWNTO 0 );
			   DATA_OUT        : OUT STD_LOGIC_VECTOR ( N_par-1 DOWNTO 0 ));
	END COMPONENT;

BEGIN
    -- assign debug signals
    WR_B_ext <= WR_B;
    DATA_IN_B_ext <= DATA_IN_B;

	-- instantiation of the DP
	Data_Path : DP PORT MAP (clk => clk, DATA_OUT_A => DATA_OUT_A, 
							 en_reg_0 => en_reg_0, en_reg_1 => en_reg_1, en_reg_2 => en_reg_2, 
							 en_reg_S => en_reg_S, clr_reg_0 => clr_reg_0, clr_reg_1 => clr_reg_1, 
							 clr_reg_2 => clr_reg_2, clr_reg_S => clr_reg_S, en_cnt => en_cnt, clr_cnt => clr_cnt, 
							 sel_mux_0 => sel_mux_0, sub_0 => sub_0, sub_1 => sub_1, sel_mux_1 => sel_mux_1, 
							 sel_mux_wr => sel_mux_wr, sat_pos => sat_pos, sat_neg => sat_neg, cnt_0 => cnt_0, 
							 TC => TC, ADDR_A => ADDR_A, ADDR_B => ADDR_B, DATA_IN_B => DATA_IN_B);
	
	-- instantiation of the CU
	Control_Unit : CU PORT MAP (clk => clk, async_rst => async_rst, start => START, 
								cnt_0 => cnt_0, TC => TC, sat_pos => sat_pos, sat_neg => sat_neg,
								CS_A => CS_A, RD_A => RD_A, WR_A => WR_A, CS_B => CS_B, RD_B => RD_B, WR_B => WR_B,
								en_reg_0 => en_reg_0, en_reg_1 => en_reg_1, en_reg_2 => en_reg_2, 
								en_reg_S => en_reg_S, clr_reg_0 => clr_reg_0, clr_reg_1 => clr_reg_1, 
								clr_reg_2 => clr_reg_2, clr_reg_S => clr_reg_S, en_cnt => en_cnt, clr_cnt => clr_cnt, 
								sel_mux_0 => sel_mux_0, sub_0 => sub_0, sub_1 => sub_1, sel_mux_1 => sel_mux_1, 
								sel_mux_wr => sel_mux_wr, done => DONE);
	
   -- instantiation of the memories	
	MEM_A : MEM PORT MAP (clk => clk, CS => CS_A, RD => RD_A, WR => WR_A, ADDR => ADDR_A, DATA_IN => DATA_IN, DATA_OUT => DATA_OUT_A );
	
	MEM_B : MEM PORT MAP (clk => clk, CS => CS_B, RD => RD_B, WR => WR_B, ADDR => ADDR_B, DATA_IN => DATA_IN_B);

END ARCHITECTURE structure;