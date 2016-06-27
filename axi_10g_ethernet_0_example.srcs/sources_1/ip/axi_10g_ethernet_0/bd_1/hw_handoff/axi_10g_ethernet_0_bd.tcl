
################################################################
# This is a generated script based on design: bd_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source bd_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7vx690tffg1157-2

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name bd_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set m_axis_rx [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_rx ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {156250000} \
CONFIG.HAS_TKEEP {1} \
CONFIG.TDATA_NUM_BYTES {8} \
 ] $m_axis_rx
  set rx_statistics [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_ten_gig_eth_mac:statistics_rtl:2.0 rx_statistics ]
  set s_axi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {16} \
CONFIG.DATA_WIDTH {32} \
 ] $s_axi
  set s_axis_pause [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_pause ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {156250000} \
 ] $s_axis_pause
  set s_axis_tx [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tx ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {156250000} \
 ] $s_axis_tx
  set tx_statistics [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_ten_gig_eth_mac:statistics_rtl:2.0 tx_statistics ]

  # Create ports
  set areset_datapathclk_out [ create_bd_port -dir O -type rst areset_datapathclk_out ]
  set coreclk_out [ create_bd_port -dir O -type clk coreclk_out ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_ASYNC_RESET {tx_axis_aresetn:rx_axis_aresetn} \
CONFIG.ASSOCIATED_BUSIF {m_axis_rx:s_axis_pause:s_axis_tx} \
CONFIG.FREQ_HZ {156250000} \
 ] $coreclk_out
  set dclk [ create_bd_port -dir I -type clk dclk ]
  set gtrxreset_out [ create_bd_port -dir O -type rst gtrxreset_out ]
  set gttxreset_out [ create_bd_port -dir O -type rst gttxreset_out ]
  set pcspma_status [ create_bd_port -dir O -from 7 -to 0 pcspma_status ]
  set qplllock_out [ create_bd_port -dir O qplllock_out ]
  set qplloutclk_out [ create_bd_port -dir O -type clk qplloutclk_out ]
  set qplloutrefclk_out [ create_bd_port -dir O -type clk qplloutrefclk_out ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {156250000} \
 ] $qplloutrefclk_out
  set refclk_n [ create_bd_port -dir I refclk_n ]
  set refclk_p [ create_bd_port -dir I refclk_p ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set reset_counter_done_out [ create_bd_port -dir O reset_counter_done_out ]
  set resetdone_out [ create_bd_port -dir O resetdone_out ]
  set rx_axis_aresetn [ create_bd_port -dir I -type rst rx_axis_aresetn ]
  set rxn [ create_bd_port -dir I rxn ]
  set rxp [ create_bd_port -dir I rxp ]
  set rxrecclk_out [ create_bd_port -dir O -type clk rxrecclk_out ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {322265625} \
 ] $rxrecclk_out
  set s_axi_aclk [ create_bd_port -dir I -type clk s_axi_aclk ]
  set s_axi_aresetn [ create_bd_port -dir I -type rst s_axi_aresetn ]
  set signal_detect [ create_bd_port -dir I signal_detect ]
  set sim_speedup_control [ create_bd_port -dir I sim_speedup_control ]
  set tx_axis_aresetn [ create_bd_port -dir I -type rst tx_axis_aresetn ]
  set tx_disable [ create_bd_port -dir O tx_disable ]
  set tx_fault [ create_bd_port -dir I tx_fault ]
  set tx_ifg_delay [ create_bd_port -dir I -from 7 -to 0 tx_ifg_delay ]
  set txn [ create_bd_port -dir O txn ]
  set txp [ create_bd_port -dir O txp ]
  set txuserrdy_out [ create_bd_port -dir O txuserrdy_out ]
  set txusrclk2_out [ create_bd_port -dir O -type clk txusrclk2_out ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {322265625} \
 ] $txusrclk2_out
  set txusrclk_out [ create_bd_port -dir O -type clk txusrclk_out ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {322265625} \
 ] $txusrclk_out
  set xgmacint [ create_bd_port -dir O -type intr xgmacint ]

  # Create instance: dcm_locked_driver, and set properties
  set dcm_locked_driver [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 dcm_locked_driver ]
  set_property -dict [ list \
CONFIG.CONST_VAL {1} \
CONFIG.CONST_WIDTH {1} \
 ] $dcm_locked_driver

  # Create instance: pma_pmd_type_driver, and set properties
  set pma_pmd_type_driver [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 pma_pmd_type_driver ]
  set_property -dict [ list \
CONFIG.CONST_VAL {5} \
CONFIG.CONST_WIDTH {3} \
 ] $pma_pmd_type_driver

  # Create instance: prtad_driver, and set properties
  set prtad_driver [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 prtad_driver ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {5} \
 ] $prtad_driver

  # Create instance: ten_gig_eth_mac, and set properties
  set ten_gig_eth_mac [ create_bd_cell -type ip -vlnv xilinx.com:ip:ten_gig_eth_mac:15.0 ten_gig_eth_mac ]
  set_property -dict [ list \
CONFIG.Data_Rate {10Gbps} \
CONFIG.Enable_Priority_Flow_Control {false} \
CONFIG.IEEE_1588 {None} \
CONFIG.Low_Latency_32_bit_MAC {64bit} \
CONFIG.Management_Frequency {200.00} \
CONFIG.Management_Interface {true} \
CONFIG.Physical_Interface {Internal} \
CONFIG.Statistics_Gathering {false} \
CONFIG.Timer_Format {Time_of_day} \
CONFIG.gt_type {GTHE3} \
 ] $ten_gig_eth_mac

  # Create instance: ten_gig_eth_pcs_pma, and set properties
  set ten_gig_eth_pcs_pma [ create_bd_cell -type ip -vlnv xilinx.com:ip:ten_gig_eth_pcs_pma:6.0 ten_gig_eth_pcs_pma ]
  set_property -dict [ list \
CONFIG.DClkRate {100.00} \
CONFIG.IEEE_1588 {None} \
CONFIG.Locations {X0Y0} \
CONFIG.MDIO_Management {true} \
CONFIG.RefClk {clk0} \
CONFIG.RefClkRate {156.25} \
CONFIG.SupportLevel {1} \
CONFIG.Timer_Format {Time_of_day} \
CONFIG.TransceiverControl {false} \
CONFIG.TransceiverInExample {false} \
CONFIG.autonegotiation {false} \
CONFIG.base_kr {BASE-R} \
CONFIG.baser32 {64bit} \
CONFIG.fec {false} \
CONFIG.no_ebuff {false} \
CONFIG.speed10_25 {10Gig} \
CONFIG.vu_gt_type {GTH} \
 ] $ten_gig_eth_pcs_pma

  # Create interface connections
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_ports s_axi] [get_bd_intf_pins ten_gig_eth_mac/s_axi]
  connect_bd_intf_net -intf_net s_axis_pause_1 [get_bd_intf_ports s_axis_pause] [get_bd_intf_pins ten_gig_eth_mac/s_axis_pause]
  connect_bd_intf_net -intf_net s_axis_tx_1 [get_bd_intf_ports s_axis_tx] [get_bd_intf_pins ten_gig_eth_mac/s_axis_tx]
  connect_bd_intf_net -intf_net ten_gig_eth_mac_m_axis_rx [get_bd_intf_ports m_axis_rx] [get_bd_intf_pins ten_gig_eth_mac/m_axis_rx]
  connect_bd_intf_net -intf_net ten_gig_eth_mac_mdio_xgmac [get_bd_intf_pins ten_gig_eth_mac/mdio_xgmac] [get_bd_intf_pins ten_gig_eth_pcs_pma/mdio_interface]
  connect_bd_intf_net -intf_net ten_gig_eth_mac_rx_statistics [get_bd_intf_ports rx_statistics] [get_bd_intf_pins ten_gig_eth_mac/rx_statistics]
  connect_bd_intf_net -intf_net ten_gig_eth_mac_tx_statistics [get_bd_intf_ports tx_statistics] [get_bd_intf_pins ten_gig_eth_mac/tx_statistics]
  connect_bd_intf_net -intf_net ten_gig_eth_mac_xgmii_xgmac [get_bd_intf_pins ten_gig_eth_mac/xgmii_xgmac] [get_bd_intf_pins ten_gig_eth_pcs_pma/xgmii_interface]
  connect_bd_intf_net -intf_net ten_gig_eth_pcs_pma_core_gt_drp_interface [get_bd_intf_pins ten_gig_eth_pcs_pma/core_gt_drp_interface] [get_bd_intf_pins ten_gig_eth_pcs_pma/user_gt_drp_interface]

  # Create port connections
  connect_bd_net -net dclk_1 [get_bd_ports dclk] [get_bd_pins ten_gig_eth_pcs_pma/dclk]
  connect_bd_net -net dcm_locked_driver_dout [get_bd_pins dcm_locked_driver/dout] [get_bd_pins ten_gig_eth_mac/rx_dcm_locked] [get_bd_pins ten_gig_eth_mac/tx_dcm_locked]
  connect_bd_net -net pma_pmd_type_driver_dout [get_bd_pins pma_pmd_type_driver/dout] [get_bd_pins ten_gig_eth_pcs_pma/pma_pmd_type]
  connect_bd_net -net prtad_driver_dout [get_bd_pins prtad_driver/dout] [get_bd_pins ten_gig_eth_pcs_pma/prtad]
  connect_bd_net -net refclk_n_1 [get_bd_ports refclk_n] [get_bd_pins ten_gig_eth_pcs_pma/refclk_n]
  connect_bd_net -net refclk_p_1 [get_bd_ports refclk_p] [get_bd_pins ten_gig_eth_pcs_pma/refclk_p]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins ten_gig_eth_mac/reset] [get_bd_pins ten_gig_eth_pcs_pma/reset]
  connect_bd_net -net rx_axis_aresetn_1 [get_bd_ports rx_axis_aresetn] [get_bd_pins ten_gig_eth_mac/rx_axis_aresetn]
  connect_bd_net -net rxn_1 [get_bd_ports rxn] [get_bd_pins ten_gig_eth_pcs_pma/rxn]
  connect_bd_net -net rxp_1 [get_bd_ports rxp] [get_bd_pins ten_gig_eth_pcs_pma/rxp]
  connect_bd_net -net s_axi_aclk_1 [get_bd_ports s_axi_aclk] [get_bd_pins ten_gig_eth_mac/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_ports s_axi_aresetn] [get_bd_pins ten_gig_eth_mac/s_axi_aresetn]
  connect_bd_net -net signal_detect_1 [get_bd_ports signal_detect] [get_bd_pins ten_gig_eth_pcs_pma/signal_detect]
  connect_bd_net -net sim_speedup_control_1 [get_bd_ports sim_speedup_control] [get_bd_pins ten_gig_eth_pcs_pma/sim_speedup_control]
  connect_bd_net -net ten_gig_eth_mac_xgmacint [get_bd_ports xgmacint] [get_bd_pins ten_gig_eth_mac/xgmacint]
  connect_bd_net -net ten_gig_eth_pcs_pma_areset_datapathclk_out [get_bd_ports areset_datapathclk_out] [get_bd_pins ten_gig_eth_pcs_pma/areset_datapathclk_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_core_status [get_bd_ports pcspma_status] [get_bd_pins ten_gig_eth_pcs_pma/core_status]
  connect_bd_net -net ten_gig_eth_pcs_pma_coreclk_out [get_bd_ports coreclk_out] [get_bd_pins ten_gig_eth_mac/rx_clk0] [get_bd_pins ten_gig_eth_mac/tx_clk0] [get_bd_pins ten_gig_eth_pcs_pma/coreclk_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_drp_req [get_bd_pins ten_gig_eth_pcs_pma/drp_gnt] [get_bd_pins ten_gig_eth_pcs_pma/drp_req]
  connect_bd_net -net ten_gig_eth_pcs_pma_gtrxreset_out [get_bd_ports gtrxreset_out] [get_bd_pins ten_gig_eth_pcs_pma/gtrxreset_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_gttxreset_out [get_bd_ports gttxreset_out] [get_bd_pins ten_gig_eth_pcs_pma/gttxreset_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_qplllock_out [get_bd_ports qplllock_out] [get_bd_pins ten_gig_eth_pcs_pma/qplllock_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_qplloutclk_out [get_bd_ports qplloutclk_out] [get_bd_pins ten_gig_eth_pcs_pma/qplloutclk_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_qplloutrefclk_out [get_bd_ports qplloutrefclk_out] [get_bd_pins ten_gig_eth_pcs_pma/qplloutrefclk_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_reset_counter_done_out [get_bd_ports reset_counter_done_out] [get_bd_pins ten_gig_eth_pcs_pma/reset_counter_done_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_resetdone_out [get_bd_ports resetdone_out] [get_bd_pins ten_gig_eth_pcs_pma/resetdone_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_rxrecclk_out [get_bd_ports rxrecclk_out] [get_bd_pins ten_gig_eth_pcs_pma/rxrecclk_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_tx_disable [get_bd_ports tx_disable] [get_bd_pins ten_gig_eth_pcs_pma/tx_disable]
  connect_bd_net -net ten_gig_eth_pcs_pma_txn [get_bd_ports txn] [get_bd_pins ten_gig_eth_pcs_pma/txn]
  connect_bd_net -net ten_gig_eth_pcs_pma_txp [get_bd_ports txp] [get_bd_pins ten_gig_eth_pcs_pma/txp]
  connect_bd_net -net ten_gig_eth_pcs_pma_txuserrdy_out [get_bd_ports txuserrdy_out] [get_bd_pins ten_gig_eth_pcs_pma/txuserrdy_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_txusrclk2_out [get_bd_ports txusrclk2_out] [get_bd_pins ten_gig_eth_pcs_pma/txusrclk2_out]
  connect_bd_net -net ten_gig_eth_pcs_pma_txusrclk_out [get_bd_ports txusrclk_out] [get_bd_pins ten_gig_eth_pcs_pma/txusrclk_out]
  connect_bd_net -net tx_axis_aresetn_1 [get_bd_ports tx_axis_aresetn] [get_bd_pins ten_gig_eth_mac/tx_axis_aresetn]
  connect_bd_net -net tx_fault_1 [get_bd_ports tx_fault] [get_bd_pins ten_gig_eth_pcs_pma/tx_fault]
  connect_bd_net -net tx_ifg_delay_1 [get_bd_ports tx_ifg_delay] [get_bd_pins ten_gig_eth_mac/tx_ifg_delay]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x0 [get_bd_addr_spaces s_axi] [get_bd_addr_segs ten_gig_eth_mac/s_axi/Reg] SEG_ten_gig_eth_mac_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


