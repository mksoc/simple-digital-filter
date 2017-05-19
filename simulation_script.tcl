restart

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top_module/filter/clk
add wave -noupdate /tb_top_module/filter/async_rst
add wave -noupdate /tb_top_module/filter/start
add wave -noupdate /tb_top_module/filter/done
add wave -noupdate /tb_top_module/filter/control_unit/ps
add wave -noupdate /tb_top_module/filter/control_unit/ns
add wave -noupdate -radix decimal /tb_top_module/filter/data_in
add wave -noupdate /tb_top_module/filter/clr_cnt
add wave -noupdate /tb_top_module/filter/en_cnt
add wave -noupdate -radix unsigned /tb_top_module/filter/data_path/cnt
add wave -noupdate /tb_top_module/filter/tc
add wave -noupdate /tb_top_module/filter/clr_reg_0
add wave -noupdate /tb_top_module/filter/clr_reg_1
add wave -noupdate /tb_top_module/filter/clr_reg_2
add wave -noupdate /tb_top_module/filter/clr_reg_s
add wave -noupdate /tb_top_module/filter/en_reg_0
add wave -noupdate /tb_top_module/filter/en_reg_1
add wave -noupdate /tb_top_module/filter/en_reg_2
add wave -noupdate /tb_top_module/filter/en_reg_s
add wave -noupdate /tb_top_module/filter/cnt_0
add wave -noupdate /tb_top_module/filter/sel_mux_0
add wave -noupdate /tb_top_module/filter/sel_mux_1
add wave -noupdate /tb_top_module/filter/sel_mux_wr
add wave -noupdate /tb_top_module/filter/sub_0
add wave -noupdate /tb_top_module/filter/sub_1
add wave -noupdate /tb_top_module/filter/sat_pos
add wave -noupdate /tb_top_module/filter/sat_neg
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_0_d
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_1_d
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_2_d
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_0_q
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_1_q
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_2_q
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/add_0
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/add_1
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_s_d
add wave -noupdate -radix decimal /tb_top_module/filter/data_path/reg_s_q
add wave -noupdate /tb_top_module/filter/cs_a
add wave -noupdate /tb_top_module/filter/rd_a
add wave -noupdate /tb_top_module/filter/wr_a
add wave -noupdate -radix unsigned /tb_top_module/filter/addr_a
add wave -noupdate -radix decimal /tb_top_module/filter/data_out_a
add wave -noupdate /tb_top_module/filter/cs_b
add wave -noupdate /tb_top_module/filter/rd_b
add wave -noupdate /tb_top_module/filter/wr_b
add wave -noupdate -radix unsigned /tb_top_module/filter/addr_b
add wave -noupdate -radix decimal /tb_top_module/filter/data_in_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {51096637 ps} 0}
configure wave -namecolwidth 119
configure wave -valuecolwidth 60
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {241054074 ps} {242049786 ps}


run 242200 ns