# PART is virtex7 xc7vx690tffg1157-2


#######################################################
# Clock/period constraints                            #
#######################################################
# Main transmit clock/period constraints

create_clock -period 5.000 [get_ports clk_in_p]
set_input_jitter clk_in_p 0.050

#######################################################
# Synchronizer False paths
#######################################################
#set_false_path -to [get_cells -hierarchical -filter {NAME =~ pattern_generator*sync1_r_reg[0]}]
#set_false_path -to [get_cells -hierarchical -filter {NAME =~ reset_error_sync_reg*sync1_r_reg[0]}]
#set_false_path -to [get_cells -hierarchical -filter {NAME =~ gen_enable_sync/sync1_r_reg[0]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ top/pattern_generator*sync1_r_reg[0]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ top/reset_error_sync_reg*sync1_r_reg[0]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ top/gen_enable_sync/sync1_r_reg[0]}]


#######################################################
# FIFO level constraints
#######################################################

#set_false_path -from [get_cells fifo_block_i/ethernet_mac_fifo_i/*/wr_store_frame_tog_reg] -to [get_cells fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
#set_max_delay 3.2000 -datapath_only  -from [get_cells {fifo_block_i/ethernet_mac_fifo_i/*/rd_addr_gray_reg_reg[*]}] -to [get_cells fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
#set_false_path -to [get_pins -filter {NAME =~ */PRE} -of_objects [get_cells {fifo_block_i/ethernet_mac_fifo_i/*/*/reset_async*_reg}]]
set_false_path -from [get_cells top/fifo_block_i/ethernet_mac_fifo_i/*/wr_store_frame_tog_reg] -to [get_cells top/fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
set_max_delay -datapath_only -from [get_cells {top/fifo_block_i/ethernet_mac_fifo_i/*/rd_addr_gray_reg_reg[*]}] -to [get_cells top/fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*] 3.200
set_false_path -to [get_pins -filter {NAME =~ */PRE} -of_objects [get_cells top/fifo_block_i/ethernet_mac_fifo_i/*/*/reset_async*_reg]]


#######################################################
# I/O constraints                                     #
#######################################################

# These inputs can be connected to dip switches or push buttons on an
# appropriate board.

#set_false_path -from [get_ports reset]
#set_false_path -from [get_ports reset_error]
#set_false_path -from [get_ports insert_error]
#set_false_path -from [get_ports pcs_loopback]
#set_false_path -from [get_ports enable_pat_gen]
#set_false_path -from [get_ports enable_pat_check]
#set_false_path -from [get_ports enable_custom_preamble]
#set_case_analysis 0  [get_ports sim_speedup_control]

# These outputs can be connected to LED's or headers on an
# appropriate board.

#set_false_path -to [get_ports core_ready]
#set_false_path -to [get_ports coreclk_out]
#set_false_path -to [get_ports qplllock_out]
#set_false_path -to [get_ports frame_error]
#set_false_path -to [get_ports gen_active_flash]
#set_false_path -to [get_ports check_active_flash]
#set_false_path -to [get_ports serialized_stats]

set_property PACKAGE_PIN AD29 [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_p]
#set_property PACKAGE_PIN H5 [get_ports clk_in_n]
#set_property IOSTANDARD LVDS [get_ports clk_in_n]
set_property PACKAGE_PIN T6 [get_ports refclk_p]

# set sfp_slot 1
# if {$sfp_slot == 0} {
set_property PACKAGE_PIN U4 [get_ports rxp]
set_property PACKAGE_PIN T2 [get_ports txp]
#} else {
# set_property PACKAGE_PIN R4 [get_ports rxp]
# set_property PACKAGE_PIN P2 [get_ports txp]
#}

#set_clock_groups -asynchronous -group refclk_p -group clk_in_p
set_clock_groups -asynchronous -group refclk_p -group s_axi_dcm_aclk0




create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_pcs_pma/U0/ten_gig_eth_pcs_pma_shared_clock_reset_block/coreclk_out]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[0]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[1]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[2]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[3]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[4]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[5]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[6]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXC[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 64 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[0]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[1]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[2]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[3]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[4]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[5]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[6]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[7]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[8]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[9]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[10]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[11]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[12]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[13]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[14]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[15]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[16]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[17]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[18]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[19]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[20]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[21]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[22]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[23]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[24]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[25]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[26]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[27]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[28]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[29]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[30]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[31]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[32]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[33]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[34]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[35]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[36]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[37]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[38]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[39]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[40]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[41]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[42]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[43]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[44]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[45]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[46]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[47]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[48]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[49]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[50]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[51]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[52]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[53]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[54]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[55]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[56]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[57]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[58]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[59]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[60]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[61]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[62]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_RXD[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[0]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[1]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[2]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[3]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[4]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[5]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[6]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXC[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 64 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[0]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[1]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[2]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[3]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[4]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[5]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[6]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[7]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[8]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[9]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[10]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[11]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[12]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[13]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[14]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[15]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[16]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[17]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[18]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[19]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[20]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[21]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[22]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[23]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[24]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[25]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[26]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[27]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[28]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[29]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[30]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[31]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[32]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[33]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[34]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[35]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[36]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[37]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[38]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[39]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[40]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[41]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[42]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[43]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[44]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[45]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[46]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[47]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[48]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[49]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[50]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[51]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[52]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[53]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[54]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[55]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[56]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[57]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[58]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[59]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[60]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[61]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[62]} {top/fifo_block_i/ethernet_core_i/U0/ten_gig_eth_mac_xgmii_xgmac_TXD[63]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets coreclk_out]
