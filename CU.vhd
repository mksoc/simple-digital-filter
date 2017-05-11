LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CU IS
	PORT ( clk, async_rst, sync_clr, start : IN STD_LOGIC;
		    cnt_0, TC, sat_pos, sat_neg : IN STD_LOGIC; 
			 CS_A, RD_A, WR_A, CS_B, RD_B, WR_B : OUT STD_LOGIC;
			 en_reg_0, en_reg_1, en_reg_2, en_reg_S, clr_reg_0, clr_reg_1, clr_reg_2, clr_reg_S : OUT STD_LOGIC;
			 en_cnt, clr_cnt, sel_mux_0, sub_0, sub_1 : OUT STD_LOGIC;
			 sel_mux_1, sel_mux_wr : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			 done : OUT STD_LOGIC );
END CU;

ARCHITECTURE states_behaviour OF CU IS

	TYPE state_type IS (Reset, Idle, State_Done, Count, Sum1_p, Sum2_p, Sum3_p, Sum1_d, Sum2_d, Sum3_d, Sat_neg_Y, Sat_pos_Y, Write_Y);
	SIGNAL PS, NS : state_type;

BEGIN


	NS_process : PROCESS ( PS, sync_clr, start, TC, cnt_0, sat_pos, sat_neg )
		BEGIN
			IF ( sync_clr = '0' ) THEN
				CASE PS IS
				
					WHEN Reset => IF ( start = '0' ) THEN
									     NS <= Idle;
									  ELSE
										  NS <= Count;
									  END IF;
									  
					WHEN Idle => IF ( start = '0' ) THEN
									    NS <= Idle;
									 ELSE
									    NS <= Count;
									 END IF;
									 
					WHEN State_Done => IF ( start = '0' ) THEN
									    NS <= Reset;
									 ELSE
										 NS <= State_Done;
									 END IF;
									 
					WHEN Count => IF ( TC = '0' ) THEN
									     NS <= Count;
									  ELSE
										  NS <= Sum1_p;
									  END IF;
									  
					WHEN Sum1_p => IF ( Sat_pos = '0' ) THEN
											IF ( Sat_neg = '0' ) THEN
												NS <= Sum2_p;
											ELSE
												NS <= Sat_pos_Y;
											END IF;
									   ELSIF ( Sat_neg = '0' ) THEN
									 	   NS <= Sat_neg_Y;
										ELSE
											NS <= Reset;
									   END IF;
										
					WHEN Sum2_p => IF ( Sat_pos = '0' ) THEN
											IF ( Sat_neg = '0' ) THEN
												NS <= Sum3_p;
											ELSE
												NS <= Sat_neg_Y;
											END IF;
									   ELSIF ( Sat_neg = '0' ) THEN
									 	   NS <= Sat_pos_Y;
										ELSE
											NS <= Reset;
									   END IF;
										
					WHEN Sum3_p => IF ( Sat_pos = '0' ) THEN
											IF ( Sat_neg = '0' ) THEN
												NS <= Write_Y;
											ELSE
												NS <= Sat_neg_Y;
											END IF;
									   ELSIF ( Sat_neg = '0' ) THEN
									 	   NS <= Sat_pos_Y;
										ELSE
											NS <= Reset;
									   END IF;
										
					WHEN Sum1_d => IF ( Sat_pos = '0' ) THEN
											IF ( Sat_neg = '0' ) THEN
												NS <= Sum2_d;
											ELSE
												NS <= Sat_neg_Y;
											END IF;
									   ELSIF ( Sat_neg = '0' ) THEN
									 	   NS <= Sat_pos_Y;
										ELSE
											NS <= Reset;
									   END IF;
										
					WHEN Sum2_d => IF ( Sat_pos = '0' ) THEN
											IF ( Sat_neg = '0' ) THEN
												NS <= Sum3_d;
											ELSE
												NS <= Sat_neg_Y;
											END IF;
									   ELSIF ( Sat_neg = '0' ) THEN
									 	   NS <= Sat_pos_Y;
										ELSE
											NS <= Reset;
									   END IF;
										
					WHEN Sum3_d => IF ( Sat_pos = '0' ) THEN
											IF ( Sat_neg = '0' ) THEN
												NS <= Write_Y;
											ELSE
												NS <= Sat_neg_Y;
											END IF;
									   ELSIF ( Sat_neg = '0' ) THEN
									 	   NS <= Sat_pos_Y;
										ELSE
											NS <= Reset;
									   END IF;
										
					WHEN Sat_pos_Y => IF ( TC = '0' ) THEN
												IF ( cnt_0 = '0' ) THEN
													NS <= Sum1_d;
												ELSE
													NS <= Sum1_p;
												END IF;
									   ELSE
									 	   NS <= State_Done;
									   END IF;
										
					WHEN Sat_neg_Y => IF ( TC = '0' ) THEN
												IF ( cnt_0 = '0' ) THEN
													NS <= Sum1_d;
												ELSE
													NS <= Sum1_p;
												END IF;
									   ELSE
									 	   NS <= State_Done;
									   END IF;
										
					WHEN Write_Y => IF ( TC = '0' ) THEN
												IF ( cnt_0 = '0' ) THEN
													NS <= Sum1_d;
												ELSE
													NS <= Sum1_p;
												END IF;
									   ELSE
									 	   NS <= State_Done;
									   END IF;
										
					WHEN OTHERS => NS <= Reset;
					
				END CASE;
			ELSE
				NS <= Reset;
			END IF;
		END PROCESS;

		
	PS_process : PROCESS ( clk, async_rst )
		BEGIN
			IF ( async_rst = '0' ) THEN
				IF ( clk'EVENT AND clk = '1' ) THEN
					PS <= NS;
				END IF;
			ELSE
				PS <= Reset;
			END IF;
		END PROCESS;
		
		
	OUTPUT_process : PROCESS ( PS )
		BEGIN
		   en_reg_0 <= '0';
			en_reg_1 <= '0';
			en_reg_2 <= '0';
			en_reg_S <= '1';
			clr_reg_0 <= '0';
			clr_reg_1 <= '0';
			clr_reg_2 <= '0';
			clr_reg_S <= '0';
			clr_cnt <= '0';
			CS_A <= '1';
			CS_B <= '1';
			RD_A <= '1';
			RD_B <= '0';
			WR_A <= '0';
			WR_B <= '0';
			sel_mux_0 <= '0';
			sel_mux_1 <= "00";
			sel_mux_wr <= "00";
			sub_0 <= '0';
			sub_1 <= '0';
			done <= '0';
			
			CASE PS IS
				WHEN Reset => en_reg_S <= '0';
								  en_cnt <= '0';
								  clr_reg_0 <= '1';
								  clr_reg_1 <= '1';
								  clr_reg_2 <= '1';
								  clr_reg_S <= '1';
								  clr_cnt <= '1';
								  CS_A <= '0';
								  CS_B <= '0';
								  RD_A <= '0';
								  
				WHEN Idle => en_reg_S <= '0';
								 en_cnt <= '0';
								 CS_A <= '0';
								 CS_B <= '0';
								 RD_A <= '0';
								  
				WHEN State_Done => en_reg_S <= '0';
								 en_cnt <= '0';
								 CS_A <= '0';
								 CS_B <= '0';
								 RD_A <= '0';
								 done <= '1';
				
				WHEN Count => en_reg_S <= '0';
								  en_cnt <= '1';
								  CS_A <= '1';
								  CS_B <= '0';
								  WR_A <= '1';
				
				WHEN Sum1_p => en_cnt <= '0';
									sub_1 <= '1';
				
				WHEN Sum2_p => en_cnt <= '0';
									sub_0 <= '1';
									sel_mux_0 <= '1';
									sel_mux_1 <= "10";
				
				WHEN Sum3_p => en_cnt <= '0';
									sel_mux_0 <= '1';
									sel_mux_1 <= "01";
									sub_1 <= '1';
				
				WHEN Sum1_d => en_cnt <= '0';
									sub_1 <= '1';
				
				WHEN Sum2_d => en_cnt <= '0';
									sel_mux_0 <= '1';
									sel_mux_1 <= "10";
									sub_1 <= '1';
				
				WHEN Sum3_d => en_cnt <= '0';
									sel_mux_0 <= '1';
									sel_mux_1 <= "01";
				
				WHEN Sat_pos_Y => en_cnt <= '1';
										en_reg_0 <= '1';
										en_reg_1 <= '1';
										en_reg_2 <= '1';
										WR_B <= '1';
										sel_mux_wr <= "01";
				
				WHEN Sat_neg_Y => en_cnt <= '1';
										en_reg_0 <= '1';
										en_reg_1 <= '1';
										en_reg_2 <= '1';
										WR_B <= '1';
										sel_mux_wr <= "10";
				
				WHEN Write_Y => en_cnt <= '1';
									 en_reg_0 <= '1';
									 en_reg_1 <= '1';
									 en_reg_2 <= '1';
									 WR_B <= '1';
									 
			END CASE;
		END PROCESS;

END ARCHITECTURE states_behaviour;