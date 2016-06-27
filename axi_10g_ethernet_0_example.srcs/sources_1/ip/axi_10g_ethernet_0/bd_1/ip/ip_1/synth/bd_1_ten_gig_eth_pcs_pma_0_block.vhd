-------------------------------------------------------------------------------
-- Title      : Block level
-- Project    : 10GBASE-R
-------------------------------------------------------------------------------
-- File       : bd_1_ten_gig_eth_pcs_pma_0_block.vhd
-------------------------------------------------------------------------------
-- Description: This file is a wrapper for the 10GBASE-R core. It contains the
-- 10GBASE-R core, the transceiver and some transceiver-related logic.
-------------------------------------------------------------------------------
-- (c) Copyright 2009 - 2014 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and 
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library ten_gig_eth_pcs_pma_v6_0_3;
use ten_gig_eth_pcs_pma_v6_0_3.all;



entity bd_1_ten_gig_eth_pcs_pma_0_block is
    port (
      dclk               : in  std_logic;
      coreclk            : in  std_logic;
      txusrclk           : in  std_logic;
      txusrclk2          : in  std_logic;
      rxrecclk_out       : out std_logic;
      txoutclk           : out std_logic;
      areset             : in  std_logic;
      areset_coreclk     : in  std_logic;
      txuserrdy          : in  std_logic;
      gttxreset          : in  std_logic;
      gtrxreset          : in  std_logic;
      sim_speedup_control: in  std_logic := '0';
      qplllock           : in  std_logic;
      qplloutclk         : in  std_logic;
      qplloutrefclk      : in  std_logic;
      reset_counter_done : in  std_logic;
      xgmii_txd        : in  std_logic_vector(63 downto 0);
      xgmii_txc        : in  std_logic_vector(7 downto 0);
      xgmii_rxd        : out std_logic_vector(63 downto 0);
      xgmii_rxc        : out std_logic_vector(7 downto 0);
      txp              : out std_logic;
      txn              : out std_logic;
      rxp              : in  std_logic;
      rxn              : in  std_logic;
      mdc              : in  std_logic;
      mdio_in          : in  std_logic;
      mdio_out         : out std_logic;
      mdio_tri         : out std_logic;
      prtad            : in  std_logic_vector(4 downto 0);
      core_status      : out std_logic_vector(7 downto 0);
      tx_resetdone     : out std_logic;
      rx_resetdone     : out std_logic;
      signal_detect    : in  std_logic;
      tx_fault         : in  std_logic;
      drp_req          : out std_logic;
      drp_gnt          : in  std_logic;
      drp_den_o        : out std_logic;
      drp_dwe_o        : out std_logic;
      drp_daddr_o      : out std_logic_vector(15 downto 0);
      drp_di_o         : out std_logic_vector(15 downto 0);
      drp_drdy_o       : out std_logic;
      drp_drpdo_o      : out std_logic_vector(15 downto 0);
      drp_den_i        : in  std_logic;
      drp_dwe_i        : in  std_logic;
      drp_daddr_i      : in  std_logic_vector(15 downto 0);
      drp_di_i         : in  std_logic_vector(15 downto 0);
      drp_drdy_i       : in  std_logic;
      drp_drpdo_i      : in  std_logic_vector(15 downto 0);
      pma_pmd_type     : in  std_logic_vector(2 downto 0);
      tx_disable       : out std_logic);
end bd_1_ten_gig_eth_pcs_pma_0_block;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

architecture wrapper of bd_1_ten_gig_eth_pcs_pma_0_block is

    attribute DowngradeIPIdentifiedWarnings: string;

    attribute DowngradeIPIdentifiedWarnings of wrapper : architecture is "yes";

----------------------------------------------------------------------------
-- Component Declaration for the 10GBASE-R core.
----------------------------------------------------------------------------

  component ten_gig_eth_pcs_pma_v6_0_3
    generic(
      C_HAS_MDIO                  : boolean := true;
      C_HAS_FEC                   : boolean := false;
      C_HAS_AN                    : boolean := false;
      C_IS_KR                     : boolean := false;
      C_NO_EBUFF                  : boolean := false;
      C_IS_32BIT                  : boolean := false;
      C_DP_WIDTH                  : integer := 64;
      C_SPEED10_25                : integer := 10;
      C_GTTYPE                    : integer := 1;
      C_GTIF_WIDTH                : integer := 32;
      C_REFCLKRATE                : integer := 156;
      C_1588                      : integer := 0
      );
    port(
      reset                : in  std_logic;
      areset_coreclk       : in  std_logic;
      txreset_txusrclk2    : in  std_logic;
      rxreset_rxusrclk2    : in  std_logic;
      areset_rxusrclk2     : in  std_logic;
      dclk_reset           : in  std_logic;
      pma_resetout         : out std_logic;
      pcs_resetout         : out std_logic;
      coreclk              : in  std_logic;
      txusrclk2            : in  std_logic;
      rxusrclk2            : in  std_logic;
      dclk                 : in  std_logic;
      fr_clk               : in  std_logic := '0';
      sim_speedup_control  : in  std_logic := '0';
      xgmii_txd            : in  std_logic_vector(63 downto 0);
      xgmii_txc            : in  std_logic_vector(7 downto 0);
      xgmii_rxd            : out std_logic_vector(63 downto 0);
      xgmii_rxc            : out std_logic_vector(7 downto 0);
      mdc                  : in  std_logic;
      mdio_in              : in  std_logic;
      mdio_out             : out std_logic;
      mdio_tri             : out std_logic;
      prtad                : in  std_logic_vector(4 downto 0);
      configuration_vector : in  std_logic_vector(535 downto 0);
      status_vector        : out std_logic_vector(447 downto 0);
      core_status          : out std_logic_vector(7 downto 0);
      pma_pmd_type         : in std_logic_vector(2 downto 0);
      lfreset              : in std_logic;
      systemtimer_s_field  : in std_logic_vector(47 downto 0)  := (others => '0');
      systemtimer_ns_field : in std_logic_vector(31 downto 0)  := (others => '0');
      correction_timer     : in std_logic_vector(63 downto 0)  := (others => '0');
      rxphy_s_field        : out std_logic_vector(47 downto 0) := (others => '0');
      rxphy_ns_field       : out std_logic_vector(35 downto 0) := (others => '0');
      rxphy_correction_timer : out std_logic_vector(63 downto 0) := (others => '0');
      gt_rxstartofseq      : in  std_logic;
      gt_latclk            : in  std_logic;
      txphy_async_gb_latency : out std_logic_vector(15 downto 0);
      drp_req              : out std_logic;
      drp_gnt              : in  std_logic;
      drp_den              : out std_logic;
      drp_dwe              : out std_logic;
      drp_daddr            : out std_logic_vector(15 downto 0);
      drp_di               : out std_logic_vector(15 downto 0);
      drp_drdy             : in  std_logic;
      drp_drpdo            : in  std_logic_vector(15 downto 0);
      gt_txd               : out std_logic_vector(31 downto 0);
      gt_txc               : out std_logic_vector(7 downto 0);
      gt_rxd               : in  std_logic_vector(31 downto 0);
      gt_rxc               : in  std_logic_vector(7 downto 0);
      gt_slip              : out std_logic;
      resetdone            : in  std_logic;
      signal_detect        : in  std_logic;
      tx_fault             : in  std_logic;
      tx_disable           : out std_logic;
      tx_prbs31_en         : out std_logic;
      rx_prbs31_en         : out std_logic;
      core_in_testmode     : out std_logic;
      clear_rx_prbs_err_count        : out  std_logic;
      loopback_ctrl        : out std_logic_vector(2 downto 0);
      is_eval              : out std_logic;
      gt_progdiv_reset     : out std_logic;
      an_enable            : in  std_logic;
      coeff_minus_1        : out std_logic_vector(4 downto 0);
      coeff_plus_1         : out std_logic_vector(4 downto 0);
      coeff_zero           : out std_logic_vector(6 downto 0);
      txdiffctrl           : out std_logic_vector(4 downto 0);
      training_enable      : in  std_logic;
      training_addr        : in  std_logic_vector(20 downto 0);
      training_rnw         : in  std_logic;
      training_wrdata      : in  std_logic_vector(15 downto 0);
      training_ipif_cs     : in  std_logic;
      training_drp_cs      : in  std_logic;
      training_rddata      : out std_logic_vector(15 downto 0);
      training_rdack       : out std_logic;
      training_wrack       : out std_logic);
  end component;

  --------------------------------------------------------------------------
 -- Component declaration for the GTH transceiver container
 --------------------------------------------------------------------------
  component bd_1_ten_gig_eth_pcs_pma_0_gtwizard_gth_10gbaser_multi_GT
generic
(
    WRAPPER_SIM_GTRESET_SPEEDUP    : string := "false";
    EXAMPLE_SIMULATION        : integer  := 0
);
port
(
    ---------------------------- Channel - DRP Ports  --------------------------
    GT0_DRPADDR_IN                              : in   std_logic_vector(8 downto 0);
    GT0_DRPCLK_IN                               : in   std_logic;
    GT0_DRPDI_IN                                : in   std_logic_vector(15 downto 0);
    GT0_DRPDO_OUT                               : out  std_logic_vector(15 downto 0);
    GT0_DRPEN_IN                                : in   std_logic;
    GT0_DRPRDY_OUT                              : out  std_logic;
    GT0_DRPWE_IN                                : in   std_logic;
    ------------------------------- Clocking Ports -----------------------------
    GT0_QPLLOUTCLK_IN                           : in   std_logic;
    GT0_QPLLOUTREFCLK_IN                        : in   std_logic;
    ------------------------------- Loopback Ports -----------------------------
    GT0_LOOPBACK_IN                             : in   std_logic_vector(2 downto 0);
    --------------------- RX Initialization and Reset Ports --------------------
    GT0_RXUSERRDY_IN                            : in   std_logic;
    ------------------ Receive Ports - FPGA RX Interface Ports -----------------
    GT0_RXUSRCLK_IN                             : in   std_logic;
    GT0_RXUSRCLK2_IN                            : in   std_logic;
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    GT0_RXDATA_OUT                              : out  std_logic_vector(31 downto 0);
    ------------------- Receive Ports - Pattern Checker Ports ------------------
    GT0_RXPRBSERR_OUT                           : out  std_logic;
    GT0_RXPRBSSEL_IN                            : in   std_logic_vector(2 downto 0);
    ------------------- Receive Ports - Pattern Checker ports ------------------
    GT0_RXPRBSCNTRESET_IN                       : in   std_logic;
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    GT0_GTHRXN_IN                               : in   std_logic;
    ------------------- Receive Ports - RX Buffer Bypass Ports -----------------
    GT0_RXBUFRESET_IN                           : in   std_logic;
    GT0_RXBUFSTATUS_OUT                         : out  std_logic_vector(2 downto 0);
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    GT0_RXDFELPMRESET_IN                        : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    GT0_RXLPMEN_IN                              : in   std_logic;
    ------------------- Receive Ports - RX Equalizer Ports ---------------------
    ------------------- Receive Ports - RX Equalizer Ports ---------------------
    GT0_RXDFEAGCHOLD_IN                         : in   std_logic;
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    GT0_RXOUTCLK_OUT                            : out  std_logic;
    ---------------------- Receive Ports - RX Gearbox Ports --------------------
    GT0_RXDATAVALID_OUT                         : out  std_logic;
    GT0_RXHEADER_OUT                            : out  std_logic_vector(1 downto 0);
    GT0_RXHEADERVALID_OUT                       : out  std_logic;
    --------------------- Receive Ports - RX Gearbox Ports  --------------------
    GT0_RXGEARBOXSLIP_IN                        : in   std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    GT0_GTRXRESET_IN                            : in   std_logic;
    GT0_RXPCSRESET_IN                           : in   std_logic;
    GT0_RXPMARESET_IN                           : in   std_logic;
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    GT0_GTHRXP_IN                               : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    GT0_RXRESETDONE_OUT                         : out  std_logic;
    GT0_RXPMARESETDONE_OUT                      : out  std_logic;
    ------------------------ TX Configurable Driver Ports ----------------------
    GT0_TXPOSTCURSOR_IN                         : in   std_logic_vector(4 downto 0);
    GT0_TXPRECURSOR_IN                          : in   std_logic_vector(4 downto 0);
    --------------------- TX Initialization and Reset Ports --------------------
    GT0_GTTXRESET_IN                            : in   std_logic;
    GT0_TXUSERRDY_IN                            : in   std_logic;
    -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
    GT0_TXHEADER_IN                             : in   std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - FPGA TX Interface Ports ----------------
    GT0_TXUSRCLK_IN                             : in   std_logic;
    GT0_TXUSRCLK2_IN                            : in   std_logic;
    --------------- Transmit Ports - TX Configurable Driver Ports --------------
    GT0_TXDIFFCTRL_IN                           : in   std_logic_vector(3 downto 0);
    GT0_TXINHIBIT_IN                            : in   std_logic;
    GT0_TXMAINCURSOR_IN                         : in   std_logic_vector(6 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    GT0_TXDATA_IN                               : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    GT0_GTHTXN_OUT                              : out  std_logic;
    GT0_GTHTXP_OUT                              : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    GT0_TXOUTCLK_OUT                            : out  std_logic;
    GT0_TXOUTCLKFABRIC_OUT                      : out  std_logic;
    GT0_TXOUTCLKPCS_OUT                         : out  std_logic;
    --------------------- Transmit Ports - TX Gearbox Ports --------------------
    GT0_TXSEQUENCE_IN                           : in   std_logic_vector(6 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    GT0_TXPCSRESET_IN                           : in   std_logic;
    GT0_TXPMARESET_IN                           : in   std_logic;
    GT0_TXRESETDONE_OUT                         : out  std_logic;
    ------------- Transceiver Debug Ports --------------------------------------
    GT0_EYESCANRESET_IN                         : in   std_logic;
    GT0_EYESCANTRIGGER_IN                       : in   std_logic;
    GT0_RXCDRHOLD_IN                            : in   std_logic;
    GT0_TXPRBSFORCEERR_IN                       : in   std_logic;
    GT0_TXPOLARITY_IN                           : in   std_logic;
    GT0_RXPOLARITY_IN                           : in   std_logic;
    GT0_RXRATE_IN                               : in   std_logic_vector(2 downto 0);
    GT0_EYESCANDATAERROR_OUT                    : out  std_logic;
    GT0_TXBUFSTATUS_OUT                         : out  std_logic_vector(1 downto 0);
    GT0_DMONITOROUT_OUT                         : out  std_logic_vector(14 downto 0);
    ------------------ Transmit Ports - pattern Generator Ports ----------------
    GT0_TXPRBSSEL_IN                            : in   std_logic_vector(2 downto 0)



);
end component;

  component bd_1_ten_gig_eth_pcs_pma_0_local_clock_and_reset
  port
  (
     areset                              : in  std_logic;
     coreclk                             : in  std_logic;
     dclk                                : in  std_logic;
     txusrclk2                           : in  std_logic;
     rxoutclk                            : in  std_logic;
     signal_detect                       : in  std_logic;
     sim_speedup_control                 : in  std_logic := '0';
     tx_resetdone                        : in  std_logic;
     rx_resetdone                        : in  std_logic;
     pma_resetout_rising                 : in  std_logic;
     qplllock_rxusrclk2                  : in  std_logic;
     gtrxreset                           : in  std_logic;
     coreclk_reset_tx                    : out std_logic;
     txreset_txusrclk2                   : out std_logic;
     rxreset_rxusrclk2                   : out std_logic;
     dclk_reset                          : out std_logic;
     areset_rxusrclk2                    : out std_logic;
     pma_resetout_rising_rxusrclk2       : out std_logic;
     rxuserrdy                           : out std_logic;
     rxusrclk                            : out std_logic;
     rxusrclk2                           : out std_logic
  );
  end component;

  component bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer
  generic
  (
    C_NUM_SYNC_REGS : integer := 3
  );
  port
  (
    clk : in std_logic;
    data_in : in std_logic;
    data_out : out std_logic
  );
  end component;

  component bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer_rst
  generic
  (
    C_NUM_SYNC_REGS : integer := 3;
    C_RVAL : std_logic := '0'
  );
  port
  (
    clk : in std_logic;
    rst : in std_logic;
    data_in : in std_logic;
    data_out : out std_logic
  );
  end component;

  component bd_1_ten_gig_eth_pcs_pma_0_cable_pull_logic
  port (
    coreclk                             : in  std_logic;
    rxusrclk2                           : in  std_logic;
    areset_rxusrclk2                    : in  std_logic;
    pma_resetout_rising_rxusrclk2       : in  std_logic;
    gt0_rxresetdone_i_reg_rxusrclk2     : in  std_logic;
    gearboxslip                         : in  std_logic;
    rx_sample_in                        : in  std_logic_vector(3 downto 0);
    cable_pull_reset_rising_reg         : out std_logic;
    cable_unpull_reset_rising_reg       : out std_logic;
    cable_is_pulled                     : out std_logic);
  end component;
----------------------------------------------------------------------------
-- Signal declarations.
---------------------------------------------------------------------------

  signal gt_txd : std_logic_vector(31 downto 0);
  signal gt_txc : std_logic_vector(7 downto 0);
  signal gt_rxd : std_logic_vector(31 downto 0);
  signal gt_rxc : std_logic_vector(7 downto 0);
  signal gt_rxd_d1 : std_logic_vector(31 downto 0);
  signal gt_rxc_d1 : std_logic_vector(7 downto 0);
  signal tx_prbs31_en : std_logic;
  signal rx_prbs31_en : std_logic;

  signal pma_resetout : std_logic;
  signal pcs_resetout : std_logic;

  signal gt0_clear_rx_prbs_err_count_i : std_logic;
  signal gt0_rxprbssel_i : std_logic_vector(2 downto 0);
  signal gt0_txprbssel_i : std_logic_vector(2 downto 0);
  signal gt0_rxgearboxslip_i : std_logic;
  signal gt0_loopback_i : std_logic_vector(2 downto 0);


  signal rxusrclk : std_logic;
  signal rxusrclk2 : std_logic;

  signal gt0_txresetdone_i : std_logic;
  signal gt0_rxresetdone_i : std_logic;

  signal gt0_rxresetdone_i_reg_rxusrclk2 : std_logic := '0';

  signal gt0_txresetdone_i_reg : std_logic;
  signal gt0_rxresetdone_i_reg : std_logic;

  signal resetdone_int     : std_logic;

  signal gt0_txheader_i : std_logic_vector(1 downto 0);
  signal gt0_txsequence_i : std_logic_vector(6 downto 0);
  signal gt0_txdata_i : std_logic_vector(31 downto 0);
  signal gt0_rxdata_i : std_logic_vector(31 downto 0);
  signal gt0_rxheader_i : std_logic_vector(1 downto 0);
  signal gt0_rxheadervalid_i : std_logic;
  signal gt0_rxdatavalid_i : std_logic;

  signal rxoutclk : std_logic;
  signal coreclk_reset_tx : std_logic;
  signal txreset_txusrclk2 : std_logic;
  signal rxreset_rxusrclk2 : std_logic;
  signal dclk_reset : std_logic;

  signal gt0_gtrxreset_i : std_logic;
  signal gt0_gttxreset_i : std_logic;
  signal pma_resetout_reg : std_logic := '0';
  signal pma_resetout_rising : std_logic;
  signal pcs_resetout_reg : std_logic := '0';
  signal pcs_resetout_rising : std_logic;
  signal gt0_rxpcsreset_i : std_logic;
  signal gt0_txpcsreset_i : std_logic;

  signal tx_disable_i     : std_logic;

  signal  gt0_rxbufreset_i : std_logic;
  signal  gt0_rxbufstatus_i : std_logic_vector(2 downto 0);

  signal core_status_i : std_logic_vector(7 downto 0);

  -- Aid detection of a cable being pulled
  signal cable_pull_reset_rising_reg  : std_logic;
  signal cable_is_pulled              : std_logic;

  -- Aid detection of a cable being plugged back in
  signal cable_unpull_reset_rising_reg  : std_logic;

  signal gt_latclk           : std_logic := '0';
  signal gt0_eyescanreset     : std_logic := '0';
  signal gt0_eyescantrigger   : std_logic := '0';
  signal gt0_rxcdrhold        : std_logic := '0';
  signal gt0_txprbsforceerr   : std_logic := '0';
  signal gt0_txpolarity       : std_logic := '0';
  signal gt0_rxpolarity       : std_logic := '0';
  signal gt0_rxrate           : std_logic_vector(2 downto 0) := "000";
  signal gt0_txprecursor      : std_logic_vector(4 downto 0) := "00000";
  signal gt0_txpostcursor     : std_logic_vector(4 downto 0) := "00000";
  signal gt0_txdiffctrl       : std_logic_vector(3 downto 0) := "1110";
  signal gt0_eyescandataerror : std_logic;
  signal gt0_txbufstatus      : std_logic_vector(1 downto 0);
  signal gt0_rxbufstatus      : std_logic_vector(2 downto 0);
  signal gt0_txpmareset       : std_logic := '0';
  signal gt0_rxpmareset       : std_logic := '0';
  signal gt0_rxpmaresetdone   : std_logic;
  signal gt0_rxdfelpmreset    : std_logic := '0';
  signal gt0_rxlpmen          : std_logic := '0';
  signal gt0_rxprbserr        : std_logic;
  signal gt0_dmonitorout      : std_logic_vector(14 downto 0);

  signal gt_progdiv_reset          : std_logic;


  -- Combination of the signal_detect input and cable_is_pulled
  signal signal_detect_comb          : std_logic := '1';
  signal signal_detect_rxusrclk2     : std_logic;
  signal signal_detect_coreclk       : std_logic;


  signal tx_resetdone_int : std_logic;
  signal rx_resetdone_int : std_logic;
  signal gtrxreset_coreclk : std_logic;
  signal qplllock_coreclk : std_logic;
  signal qplllock_txusrclk2 : std_logic;
  signal qplllock_rxusrclk2 : std_logic;
  signal qplllock_coreclk_tmp : std_logic;
  signal qplllock_txusrclk2_tmp : std_logic;
  signal qplllock_rxusrclk2_tmp : std_logic;

  signal areset_rxusrclk2                    : std_logic;
  signal pma_resetout_rising_rxusrclk2       : std_logic;
  signal gt0_rxuserrdy_i                     : std_logic;


  -- 750ms is equivalent to 117188000 cycles of coreclk (6.4ns per cycle)
  -- 117188000 in hex = x6FC25A0
  constant MASTER_WATCHDOG_TIMER_RESET : std_logic_vector(28 downto 0) := "00110111111000010010110100000";

  signal master_watchdog : std_logic_vector(28 downto 0) := MASTER_WATCHDOG_TIMER_RESET;
  signal master_watchdog_barking : std_logic;
  signal core_in_testmode : std_logic;

  signal qplllock_int : std_logic;
  signal gt0_txresetdone_reg     : std_logic := '0';
  signal gt0_txresetdone_reg1    : std_logic := '0';
  signal gt0_rxresetdone_reg     : std_logic := '0';
  signal gt0_rxresetdone_reg1    : std_logic := '0';
  signal gt0_rxresetdone_reg_dup : std_logic := '0';

  attribute DONT_TOUCH : string;
  attribute DONT_TOUCH of gt0_rxresetdone_reg : signal is "YES";
  attribute DONT_TOUCH of gt0_rxresetdone_reg_dup : signal is "YES";



begin

  rxrecclk_out <= rxusrclk2;


  qplllock_int <= qplllock;

  -- Local clocking/reset block
  bd_1_ten_gig_eth_pcs_pma_0_local_clock_reset_block : bd_1_ten_gig_eth_pcs_pma_0_local_clock_and_reset
    port map
    (
      areset                              => areset,
      coreclk                             => coreclk,
      dclk                                => dclk,
      txusrclk2                           => txusrclk2,
      rxoutclk                            => rxoutclk,
      signal_detect                       => signal_detect,
      sim_speedup_control                 => sim_speedup_control,
      tx_resetdone                        => tx_resetdone_int,
      rx_resetdone                        => rx_resetdone_int,
      pma_resetout_rising                 => pma_resetout_rising,
      qplllock_rxusrclk2                  => qplllock_rxusrclk2,
      gtrxreset                           => gt0_gtrxreset_i,
      coreclk_reset_tx                    => coreclk_reset_tx,
      txreset_txusrclk2                   => txreset_txusrclk2,
      rxreset_rxusrclk2                   => rxreset_rxusrclk2,
      dclk_reset                          => dclk_reset,
      areset_rxusrclk2                    => areset_rxusrclk2,
      pma_resetout_rising_rxusrclk2       => pma_resetout_rising_rxusrclk2,
      rxuserrdy                           => gt0_rxuserrdy_i,
      rxusrclk                            => rxusrclk,
      rxusrclk2                           => rxusrclk2
    );

  rx_resetdone <= rx_resetdone_int;
  tx_resetdone <= tx_resetdone_int;


  gt_progdiv_reset <= '0';

  gtrxreset_coreclk_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer_rst
    generic map(
      C_NUM_SYNC_REGS => 5,
      C_RVAL => '1')
    port map(
      clk      => coreclk,
      rst      => gtrxreset,
      data_in  => '0',
      data_out => gtrxreset_coreclk
    );

  qplllock_coreclk_tmp <= not(qplllock_int);
  qplllock_coreclk_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer_rst
    generic map(
      C_NUM_SYNC_REGS => 5,
      C_RVAL => '0')
    port map(
      clk      => coreclk,
      rst      => qplllock_coreclk_tmp,
      data_in  => '1',
      data_out => qplllock_coreclk
    );

  qplllock_txusrclk2_tmp <= not(qplllock_int);
  qplllock_txusrclk2_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer_rst
    generic map(
      C_NUM_SYNC_REGS => 5,
      C_RVAL => '0')
    port map(
      clk      => txusrclk2,
      rst      => qplllock_txusrclk2_tmp,
      data_in  => '1',
      data_out => qplllock_txusrclk2
    );

  qplllock_rxusrclk2_tmp <= not(qplllock_int);
  qplllock_rxusrclk2_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer_rst
    generic map(
      C_NUM_SYNC_REGS => 5,
      C_RVAL => '0')
    port map(
      clk      => rxusrclk2,
      rst      => qplllock_rxusrclk2_tmp,
      data_in  => '1',
      data_out => qplllock_rxusrclk2
    );

  gt0_txresetdone_proc : process(txusrclk2)
  begin
    if(txusrclk2'event and txusrclk2 = '1') then
      gt0_txresetdone_reg  <= gt0_txresetdone_i and qplllock_txusrclk2;
--To resolve CDC-11 Critical Fan-out from launch flop to destination clock 
      gt0_txresetdone_reg1 <= gt0_txresetdone_reg;
    end if;
  end process;

  gt0_rxresetdone_proc : process(rxusrclk2)
  begin
    if(rxusrclk2'event and rxusrclk2 = '1') then
      gt0_rxresetdone_reg     <= gt0_rxresetdone_i and qplllock_rxusrclk2;
--To resolve CDC-11 Critical Fan-out from launch flop to destination clock 
      gt0_rxresetdone_reg_dup <= gt0_rxresetdone_i and qplllock_rxusrclk2;
      gt0_rxresetdone_reg1    <= gt0_rxresetdone_reg;
    end if;
  end process;

  bd_1_ten_gig_eth_pcs_pma_0_core : ten_gig_eth_pcs_pma_v6_0_3
    generic map(
      C_HAS_MDIO                  => true,
      C_HAS_FEC                   => false,
      C_HAS_AN                    => false,
      C_IS_KR                     => false,
      C_NO_EBUFF                  => false,
      C_IS_32BIT                  => false,
      C_DP_WIDTH                  => 64,
      C_SPEED10_25                => 10,
      C_GTTYPE                    => 1,
      C_GTIF_WIDTH                => 32,
      C_REFCLKRATE                => 156,
      C_1588                      => 0
    )
    port map (
      reset                => coreclk_reset_tx,
      areset_coreclk       => areset_coreclk,
      txreset_txusrclk2    => txreset_txusrclk2,
      rxreset_rxusrclk2    => rxreset_rxusrclk2,
      areset_rxusrclk2     => areset_rxusrclk2,
      dclk_reset           => dclk_reset,
      pma_resetout         => pma_resetout,
      pcs_resetout         => pcs_resetout,
      coreclk              => coreclk,
      txusrclk2            => txusrclk2,
      rxusrclk2            => rxusrclk2,
      dclk                 => dclk,
      fr_clk               => coreclk,
      sim_speedup_control  => sim_speedup_control,
      xgmii_txd            => xgmii_txd,
      xgmii_txc            => xgmii_txc,
      xgmii_rxd            => xgmii_rxd,
      xgmii_rxc            => xgmii_rxc,
      mdc                  => mdc,
      mdio_in              => mdio_in,
      mdio_out             => mdio_out,
      mdio_tri             => mdio_tri,
      prtad                => prtad,
      configuration_vector => (others => '0'),
      status_vector        => open,
      core_status          => core_status_i,
      pma_pmd_type         => pma_pmd_type,
      gt_latclk            => '0',
      txphy_async_gb_latency => open,
      lfreset              => '0',
      systemtimer_s_field  => (others => '0'),
      systemtimer_ns_field => (others => '0'),
      correction_timer     => (others => '0'),
      rxphy_s_field        => open,
      rxphy_ns_field       => open,
      rxphy_correction_timer => open,
      gt_rxstartofseq      => '0',
      drp_req              => drp_req,
      drp_gnt              => drp_gnt,
      drp_den              => drp_den_o,
      drp_dwe              => drp_dwe_o,
      drp_daddr            => drp_daddr_o,
      drp_di               => drp_di_o,
      drp_drdy             => drp_drdy_i,
      drp_drpdo            => drp_drpdo_i,
      gt_txd               => gt_txd,
      gt_txc               => gt_txc,
      gt_rxd               => gt_rxd_d1,
      gt_rxc               => gt_rxc_d1,
      gt_slip              => gt0_rxgearboxslip_i,
      resetdone            => resetdone_int,
      signal_detect        => signal_detect_comb,
      tx_fault             => tx_fault,
      tx_disable           => tx_disable_i,
      tx_prbs31_en         => tx_prbs31_en,
      rx_prbs31_en         => rx_prbs31_en,
      core_in_testmode     => core_in_testmode,
      clear_rx_prbs_err_count        => gt0_clear_rx_prbs_err_count_i,
      loopback_ctrl        => gt0_loopback_i,
      is_eval              => open,
      gt_progdiv_reset     => open,
      an_enable            => '0',
      coeff_minus_1        => open,
      coeff_plus_1         => open,
      coeff_zero           => open,
      txdiffctrl           => open,
      training_enable      => '0',
      training_addr        => (others => '0'),
      training_rnw         => '0',
      training_wrdata      => (others => '0'),
      training_ipif_cs     => '0',
      training_drp_cs      => '0',
      training_rddata      => open,
      training_rdack       => open,
      training_wrack       => open);


  tx_disable <= tx_disable_i;


  gt0_txresetdone_i_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer
    generic map(
      C_NUM_SYNC_REGS => 5)
    port map(
      clk      => coreclk,
      data_in  => gt0_txresetdone_reg1,
      data_out => gt0_txresetdone_i_reg
    );

  gt0_rxresetdone_i_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer
    generic map(
      C_NUM_SYNC_REGS => 5)
    port map(
      clk      => coreclk,
      data_in  => gt0_rxresetdone_reg1,
      data_out => gt0_rxresetdone_i_reg
    );

  resetdone_int <= gt0_txresetdone_i_reg and gt0_rxresetdone_i_reg;
  tx_resetdone_int <= gt0_txresetdone_i_reg;
  rx_resetdone_int <= gt0_rxresetdone_i_reg;


  gt0_txdata_i(0 ) <= gt_txd(31);
  gt0_txdata_i(1 ) <= gt_txd(30);
  gt0_txdata_i(2 ) <= gt_txd(29);
  gt0_txdata_i(3 ) <= gt_txd(28);
  gt0_txdata_i(4 ) <= gt_txd(27);
  gt0_txdata_i(5 ) <= gt_txd(26);
  gt0_txdata_i(6 ) <= gt_txd(25);
  gt0_txdata_i(7 ) <= gt_txd(24);
  gt0_txdata_i(8 ) <= gt_txd(23);
  gt0_txdata_i(9 ) <= gt_txd(22);
  gt0_txdata_i(10) <= gt_txd(21);
  gt0_txdata_i(11) <= gt_txd(20);
  gt0_txdata_i(12) <= gt_txd(19);
  gt0_txdata_i(13) <= gt_txd(18);
  gt0_txdata_i(14) <= gt_txd(17);
  gt0_txdata_i(15) <= gt_txd(16);
  gt0_txdata_i(16) <= gt_txd(15);
  gt0_txdata_i(17) <= gt_txd(14);
  gt0_txdata_i(18) <= gt_txd(13);
  gt0_txdata_i(19) <= gt_txd(12);
  gt0_txdata_i(20) <= gt_txd(11);
  gt0_txdata_i(21) <= gt_txd(10);
  gt0_txdata_i(22) <= gt_txd(9 );
  gt0_txdata_i(23) <= gt_txd(8 );
  gt0_txdata_i(24) <= gt_txd(7 );
  gt0_txdata_i(25) <= gt_txd(6 );
  gt0_txdata_i(26) <= gt_txd(5 );
  gt0_txdata_i(27) <= gt_txd(4 );
  gt0_txdata_i(28) <= gt_txd(3 );
  gt0_txdata_i(29) <= gt_txd(2 );
  gt0_txdata_i(30) <= gt_txd(1 );
  gt0_txdata_i(31) <= gt_txd(0 );
  gt0_txheader_i(0) <= gt_txc(1);
  gt0_txheader_i(1) <= gt_txc(0);
  gt0_txsequence_i <= '0' & gt_txc(7 downto 2);

  gt_rxd(0 ) <= gt0_rxdata_i(31);
  gt_rxd(1 ) <= gt0_rxdata_i(30);
  gt_rxd(2 ) <= gt0_rxdata_i(29);
  gt_rxd(3 ) <= gt0_rxdata_i(28);
  gt_rxd(4 ) <= gt0_rxdata_i(27);
  gt_rxd(5 ) <= gt0_rxdata_i(26);
  gt_rxd(6 ) <= gt0_rxdata_i(25);
  gt_rxd(7 ) <= gt0_rxdata_i(24);
  gt_rxd(8 ) <= gt0_rxdata_i(23);
  gt_rxd(9 ) <= gt0_rxdata_i(22);
  gt_rxd(10) <= gt0_rxdata_i(21);
  gt_rxd(11) <= gt0_rxdata_i(20);
  gt_rxd(12) <= gt0_rxdata_i(19);
  gt_rxd(13) <= gt0_rxdata_i(18);
  gt_rxd(14) <= gt0_rxdata_i(17);
  gt_rxd(15) <= gt0_rxdata_i(16);
  gt_rxd(16) <= gt0_rxdata_i(15);
  gt_rxd(17) <= gt0_rxdata_i(14);
  gt_rxd(18) <= gt0_rxdata_i(13);
  gt_rxd(19) <= gt0_rxdata_i(12);
  gt_rxd(20) <= gt0_rxdata_i(11);
  gt_rxd(21) <= gt0_rxdata_i(10);
  gt_rxd(22) <= gt0_rxdata_i(9 );
  gt_rxd(23) <= gt0_rxdata_i(8 );
  gt_rxd(24) <= gt0_rxdata_i(7 );
  gt_rxd(25) <= gt0_rxdata_i(6 );
  gt_rxd(26) <= gt0_rxdata_i(5 );
  gt_rxd(27) <= gt0_rxdata_i(4 );
  gt_rxd(28) <= gt0_rxdata_i(3 );
  gt_rxd(29) <= gt0_rxdata_i(2 );
  gt_rxd(30) <= gt0_rxdata_i(1 );
  gt_rxd(31) <= gt0_rxdata_i(0 );
  gt_rxc <= "0000" & gt0_rxheadervalid_i & gt0_rxdatavalid_i & gt0_rxheader_i(0) & gt0_rxheader_i(1);
  gt_rx_reg : process(rxusrclk2)
  begin
    if(rxusrclk2'event and rxusrclk2 = '1') then
      gt_rxc_d1 <= gt_rxc;
      gt_rxd_d1 <= gt_rxd;
    end if;
  end process;

  -- The route from the GT to the fabric for this signal may be longer than the clock period
  -- so add a synchronizer
  gt0_rxresetdone_i_reg_rxusrclk2_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer
  generic map(
    C_NUM_SYNC_REGS => 5)
  port map(
    clk      => rxusrclk2,
    data_in  => gt0_rxresetdone_reg_dup,
    data_out => gt0_rxresetdone_i_reg_rxusrclk2
  );

  -- Create a watchdog which samples 4 bits from the gt_rxd vector and checks that it does
  -- vary from a 1010 or 0101 or 0000 pattern. If not then there may well have been a cable pull
  -- and the gt rx side needs to be reset.
  cable_pull_logic_i : bd_1_ten_gig_eth_pcs_pma_0_cable_pull_logic
  port map
  (
    coreclk => coreclk,
    rxusrclk2 => rxusrclk2,
    areset_rxusrclk2 => areset_rxusrclk2,
    pma_resetout_rising_rxusrclk2 => pma_resetout_rising_rxusrclk2,
    gt0_rxresetdone_i_reg_rxusrclk2 => gt0_rxresetdone_i_reg_rxusrclk2,
    gearboxslip => gt0_rxgearboxslip_i,
    rx_sample_in => gt_rxd(7 downto 4),
    cable_pull_reset_rising_reg => cable_pull_reset_rising_reg,
    cable_unpull_reset_rising_reg => cable_unpull_reset_rising_reg,
    cable_is_pulled => cable_is_pulled
  );

  -- Sync the sig_det signal to the rxusrclk2 domain
  signal_detect_rxusrclk2_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer
  generic map(
    C_NUM_SYNC_REGS => 5)
  port map(
    clk      => rxusrclk2,
    data_in  => signal_detect,
    data_out => signal_detect_rxusrclk2
  );

  -- Create the signal_detect signal as an AND of the external signal and (not) the local cable_is_pulled
  sigdetcomb_proc: process(rxusrclk2)
  begin
    if(rxusrclk2'event and rxusrclk2 = '1') then
      signal_detect_comb <= signal_detect_rxusrclk2 and not(cable_is_pulled);
    end if;
  end process;

  core_status <= core_status_i;



  pma_rst_proc : process(coreclk)
  begin
    if(coreclk'event and coreclk = '1') then
      if(areset_coreclk = '1') then
        pma_resetout_reg <= '0';
      else
        pma_resetout_reg <= pma_resetout;
      end if;
    end if;
  end process;

  pma_resetout_rising <= pma_resetout and not(pma_resetout_reg);

  pcs_rst_proc : process(coreclk)
  begin
    if(coreclk'event and coreclk = '1') then
      if(areset_coreclk = '1') then
        pcs_resetout_reg <= '0';
      else
        pcs_resetout_reg <= pcs_resetout;
      end if;
    end if;
  end process;

  pcs_resetout_rising <= pcs_resetout and not(pcs_resetout_reg);


  -- Sync the sig_det signal to the coreclk domain
  signal_detect_coreclk_sync_i : bd_1_ten_gig_eth_pcs_pma_0_ff_synchronizer
  generic map(
    C_NUM_SYNC_REGS => 5)
  port map(
    clk      => coreclk,
    data_in  => signal_detect,
    data_out => signal_detect_coreclk
  );

  -- Create a master reset watchdog which toggles GTRXRESET after 750ms of not getting to PCS Block Lock
  master_wdog_proc : process (coreclk)
   begin
     if(coreclk'event and coreclk = '1') then
       if(resetdone_int = '0' or core_status_i(0) = '1' or core_in_testmode = '1') then
         master_watchdog <= MASTER_WATCHDOG_TIMER_RESET;
       else
         master_watchdog <= master_watchdog - 1;
       end if;
     end if;
  end process;

   master_wdog_barking_proc : process(master_watchdog)
  begin
     if (master_watchdog = "00000000000000000000000000000") then
       master_watchdog_barking <= '1';
     else
       master_watchdog_barking <= '0';
     end if;
  end process;

  -- Incorporate the pma_resetout_rising and cable_pull/unpull_reset_rising bits generated in code below.
  gt0_gtrxreset_i <= (gtrxreset_coreclk or not(qplllock_coreclk) or pma_resetout_rising or not(signal_detect_coreclk) or master_watchdog_barking or
                      cable_pull_reset_rising_reg or cable_unpull_reset_rising_reg) and reset_counter_done;
  gt0_gttxreset_i <= (gttxreset or not(qplllock_coreclk) or pma_resetout_rising) and reset_counter_done;

  gt0_rxpcsreset_i <= pcs_resetout_rising;
  gt0_txpcsreset_i <= pcs_resetout_rising;

  gt0_rxprbssel_i      <= rx_prbs31_en & "00";
  gt0_txprbssel_i      <= tx_prbs31_en & "00";

  -- reset the GT RX Buffer when over/underflowing
  bufresetproc: process(rxusrclk2)
  begin
    if(rxusrclk2'event and rxusrclk2 = '1') then
      if(gt0_rxbufstatus_i(2) = '1' and gt0_rxresetdone_i_reg_rxusrclk2 = '1') then
        gt0_rxbufreset_i <= '1';
      else
        gt0_rxbufreset_i <= '0';
      end if;
    end if;
  end process;


  ----------------------------- The GT Wrapper -----------------------------

  -- As generated by the GT Wizard - cut from _top level in eg design dir
  -- Use this example as a template for any updates - some signal names in
  -- port mappings may have been changed from the GT wizard output


  gt0_gtwizard_10gbaser_multi_gt_i : bd_1_ten_gig_eth_pcs_pma_0_gtwizard_gth_10gbaser_multi_GT
  generic map
  (
      WRAPPER_SIM_GTRESET_SPEEDUP =>      "TRUE",
      EXAMPLE_SIMULATION          =>      0
  )
  port map
  (
        ---------------------------------- Channel ---------------------------------
        gt0_qplloutclk_in                   =>      qplloutclk,
        gt0_qplloutrefclk_in                =>      qplloutrefclk,
        ---------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
        gt0_drpaddr_in                      =>      drp_daddr_i(8 downto 0),
        gt0_drpclk_in                       =>      dclk,
        gt0_drpdi_in                        =>      drp_di_i,
        gt0_drpdo_out                       =>      drp_drpdo_o,
        gt0_drpen_in                        =>      drp_den_i,
        gt0_drprdy_out                      =>      drp_drdy_o,
        gt0_drpwe_in                        =>      drp_dwe_i,
        ------------------------ Loopback and Powerdown Ports ----------------------
        gt0_loopback_in                     =>      gt0_loopback_i,
        ------------------------------- Receive Ports ------------------------------
        gt0_rxuserrdy_in                    =>      gt0_rxuserrdy_i,
        -------------- Receive Ports - 64b66b and 64b67b Gearbox Ports -------------
        gt0_rxdatavalid_out                 =>      gt0_rxdatavalid_i,
        gt0_rxgearboxslip_in                =>      gt0_rxgearboxslip_i,
        gt0_rxheader_out                    =>      gt0_rxheader_i,
        gt0_rxheadervalid_out               =>      gt0_rxheadervalid_i,
        ----------------------- Receive Ports - PRBS Detection ---------------------
        gt0_rxprbscntreset_in               =>      gt0_clear_rx_prbs_err_count_i,
        gt0_rxprbserr_out                   =>      gt0_rxprbserr,
        gt0_rxprbssel_in                    =>      gt0_rxprbssel_i,
        ------------------- Receive Ports - RX Data Path interface -----------------
        gt0_gtrxreset_in                    =>      gt0_gtrxreset_i,
        gt0_rxdata_out                      =>      gt0_rxdata_i,
        gt0_rxdfeagchold_in                 =>      '0',
        gt0_rxoutclk_out                    =>      rxoutclk,
        gt0_rxpcsreset_in                   =>      gt0_rxpcsreset_i,
        gt0_rxpmareset_in                   =>      gt0_rxpmareset,
        gt0_rxpmaresetdone_out              =>      open,
        gt0_rxusrclk_in                     =>      rxusrclk,
        gt0_rxusrclk2_in                    =>      rxusrclk2,
        ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        gt0_gthrxn_in                       =>      rxn,
        gt0_gthrxp_in                       =>      rxp,
        -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        gt0_rxbufreset_in                   =>      gt0_rxbufreset_i,
        gt0_rxbufstatus_out                 =>      gt0_rxbufstatus_i,
        ------------------- Receive Ports - RX Equalizer Ports -------------------
        gt0_rxdfelpmreset_in                =>      gt0_rxdfelpmreset,
        ------------------------ Receive Ports - RX Equalizer ----------------------
        gt0_rxlpmen_in                      =>      gt0_rxlpmen,
        ------------------------ Receive Ports - RX PLL Ports ----------------------
        gt0_rxresetdone_out                 =>      gt0_rxresetdone_i,
        ------------------------------- Transmit Ports -----------------------------
        gt0_txuserrdy_in                    =>      txuserrdy,
        -------------- Transmit Ports - 64b66b and 64b67b Gearbox Ports ------------
        gt0_txheader_in                     =>      gt0_txheader_i,
        gt0_txsequence_in                   =>      gt0_txsequence_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt0_gttxreset_in                    =>      gt0_gttxreset_i,
        gt0_txdata_in                       =>      gt0_txdata_i,
        gt0_txoutclk_out                    =>      txoutclk,
        gt0_txoutclkfabric_out              =>      open,
        gt0_txoutclkpcs_out                 =>      open,
        gt0_txpcsreset_in                   =>      gt0_txpcsreset_i,
        gt0_txpmareset_in                   =>      gt0_txpmareset,
        gt0_txusrclk_in                     =>      txusrclk,
        gt0_txusrclk2_in                    =>      txusrclk2,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt0_gthtxn_out                      =>      txn,
        gt0_gthtxp_out                      =>      txp,
        gt0_txinhibit_in                    =>      tx_disable_i,
        gt0_txprecursor_in                  =>      gt0_txprecursor,
        gt0_txpostcursor_in                 =>      gt0_txpostcursor,
        gt0_txdiffctrl_in                   =>      gt0_txdiffctrl,
        gt0_txmaincursor_in                 =>      "0000000",
        ----------------------- Transmit Ports - TX PLL Ports ----------------------
        gt0_txresetdone_out                =>      gt0_txresetdone_i,
        ------------------- Transceiver Debug Ports ------------------------------
        gt0_eyescanreset_in                =>       gt0_eyescanreset,
        gt0_eyescantrigger_in              =>       gt0_eyescantrigger,
        gt0_rxcdrhold_in                   =>       gt0_rxcdrhold,
        gt0_txprbsforceerr_in              =>       gt0_txprbsforceerr,
        gt0_txpolarity_in                  =>       gt0_txpolarity,
        gt0_rxpolarity_in                  =>       gt0_rxpolarity,
        gt0_rxrate_in                      =>       gt0_rxrate,
        gt0_eyescandataerror_out           =>       gt0_eyescandataerror,
        gt0_txbufstatus_out                =>       gt0_txbufstatus,
        gt0_dmonitorout_out                =>       gt0_dmonitorout,
        --------------------- Transmit Ports - TX PRBS Generator -------------------
        gt0_txprbssel_in                   =>      gt0_txprbssel_i
  );

end wrapper;
