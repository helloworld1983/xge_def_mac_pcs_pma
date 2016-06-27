-------------------------------------------------------------------------------
-- Title      : Core level wrapper
-- Project    : 10GBASE-R
-------------------------------------------------------------------------------
-- File       : bd_1_ten_gig_eth_pcs_pma_0.vhd
-------------------------------------------------------------------------------
-- Description: This file is a wrapper for the 10GBASE-R core.
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

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library ten_gig_eth_pcs_pma_v6_0_3;
use ten_gig_eth_pcs_pma_v6_0_3.all;

entity bd_1_ten_gig_eth_pcs_pma_0 is
  port (
      dclk               : in  std_logic;
      rxrecclk_out       : out std_logic;
      refclk_p           : in  std_logic;
      refclk_n           : in  std_logic;
      sim_speedup_control: in  std_logic := '0';
      coreclk_out    : out std_logic;
      qplloutclk_out     : out std_logic;
      qplloutrefclk_out  : out std_logic;
      qplllock_out       : out std_logic;
      txusrclk_out       : out std_logic;
      txusrclk2_out      : out std_logic;
      areset_datapathclk_out  : out std_logic;
      gttxreset_out      : out std_logic;
      gtrxreset_out      : out std_logic;
      txuserrdy_out      : out std_logic;
      reset_counter_done_out : out std_logic;
      reset              : in  std_logic;
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
      resetdone_out    : out std_logic;
      signal_detect    : in  std_logic;
      tx_fault         : in  std_logic;
      drp_req          : out std_logic;
      drp_gnt          : in  std_logic;
      drp_den_o        : out std_logic;
      drp_dwe_o        : out std_logic;
      drp_daddr_o      : out std_logic_vector(15 downto 0);
      drp_di_o         : out std_logic_vector(15 downto 0);
      drp_drdy_i       : in  std_logic;
      drp_drpdo_i      : in  std_logic_vector(15 downto 0);
      drp_den_i        : in  std_logic;
      drp_dwe_i        : in  std_logic;
      drp_daddr_i      : in  std_logic_vector(15 downto 0);
      drp_di_i         : in  std_logic_vector(15 downto 0);
      drp_drdy_o       : out std_logic;
      drp_drpdo_o      : out std_logic_vector(15 downto 0);
      pma_pmd_type     : in std_logic_vector(2 downto 0);
      tx_disable       : out std_logic);
end bd_1_ten_gig_eth_pcs_pma_0;

architecture wrapper of bd_1_ten_gig_eth_pcs_pma_0 is

    attribute DowngradeIPIdentifiedWarnings: string;

    attribute DowngradeIPIdentifiedWarnings of wrapper : architecture is "yes";


  component bd_1_ten_gig_eth_pcs_pma_0_support is
    port (
      refclk_p             : in  std_logic;
      refclk_n             : in  std_logic;
      dclk                 : in  std_logic;
      sim_speedup_control  : in  std_logic := '0';
      coreclk_out          : out std_logic;
      rxrecclk_out         : out std_logic;
      qplloutclk_out       : out std_logic;
      qplloutrefclk_out    : out std_logic;
      qplllock_out         : out std_logic;
      txusrclk_out         : out std_logic;
      txusrclk2_out        : out std_logic;
      areset_datapathclk_out  : out std_logic;
      gttxreset_out        : out std_logic;
      gtrxreset_out        : out std_logic;
      txuserrdy_out        : out std_logic;
      reset_counter_done_out : out std_logic;
      reset                : in  std_logic;
      xgmii_txd            : in  std_logic_vector(63 downto 0);
      xgmii_txc            : in  std_logic_vector(7 downto 0);
      xgmii_rxd            : out std_logic_vector(63 downto 0);
      xgmii_rxc            : out std_logic_vector(7 downto 0);
      txp                  : out std_logic;
      txn                  : out std_logic;
      rxp                  : in  std_logic;
      rxn                  : in  std_logic;
      resetdone_out        : out std_logic;
      signal_detect        : in  std_logic;
      tx_fault             : in  std_logic;
      drp_req              : out std_logic;
      drp_gnt              : in  std_logic;
      drp_den_o            : out std_logic;
      drp_dwe_o            : out std_logic;
      drp_daddr_o          : out std_logic_vector(15 downto 0);
      drp_di_o             : out std_logic_vector(15 downto 0);
      drp_drdy_i           : in  std_logic;
      drp_drpdo_i          : in  std_logic_vector(15 downto 0);
      drp_den_i            : in  std_logic;
      drp_dwe_i            : in  std_logic;
      drp_daddr_i          : in  std_logic_vector(15 downto 0);
      drp_di_i             : in  std_logic_vector(15 downto 0);
      drp_drdy_o           : out std_logic;
      drp_drpdo_o          : out std_logic_vector(15 downto 0);
      tx_disable           : out std_logic;
      mdc                  : in  std_logic;
      mdio_in              : in  std_logic;
      mdio_out             : out std_logic;
      mdio_tri             : out std_logic;
      prtad                : in  std_logic_vector(4 downto 0);
      pma_pmd_type         : in std_logic_vector(2 downto 0);
      core_status          : out std_logic_vector(7 downto 0));
  end component;

  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF wrapper : ARCHITECTURE IS "bd_1_ten_gig_eth_pcs_pma_0,ten_gig_eth_pcs_pma_v6_0_3,{x_ipProduct=Vivado 2015.4.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=ten_gig_eth_pcs_pma,x_ipVersion=6.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,x_ipLicense=ten_gig_eth_pcs_pma_basekr@2015.04(design_linking),c_family=virtex7,c_component_name=bd_1_ten_gig_eth_pcs_pma_0,c_has_mdio=true,c_has_fec=false,c_has_an=false,c_is_kr=false,c_is_32bit=false,c_no_ebuff=false,c_gttype=1,c_1588=0,c_gtif_width=32,c_speed10_25=10,c_sub_core_name=bd_1_ten_gig_eth_pcs_pma_0_gt,c_gt_loc=X0Y0,c_refclk=clk0,c_refclkrate=156,c_dclkrate=100.00}";
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF wrapper: ARCHITECTURE IS "ten_gig_eth_pcs_pma_v6_0_3,Vivado 2015.4.1";
begin
--
-- Instantiate the 10Gig PCS/PMA core
--
  U0 : bd_1_ten_gig_eth_pcs_pma_0_support
    port map (
      refclk_p            => refclk_p,
      refclk_n            => refclk_n,
      dclk                => dclk,
      sim_speedup_control => sim_speedup_control,
      coreclk_out     => coreclk_out,
      rxrecclk_out => rxrecclk_out,
      qplloutclk_out      => qplloutclk_out,
      qplloutrefclk_out   => qplloutrefclk_out,
      qplllock_out        => qplllock_out,
      txusrclk_out        => txusrclk_out,
      txusrclk2_out       => txusrclk2_out,
      areset_datapathclk_out  => areset_datapathclk_out,
      gttxreset_out       => gttxreset_out,
      gtrxreset_out       => gtrxreset_out,
      txuserrdy_out       => txuserrdy_out,
      reset_counter_done_out => reset_counter_done_out,
      reset               => reset,
      xgmii_txd           => xgmii_txd,
      xgmii_txc           => xgmii_txc,
      xgmii_rxd           => xgmii_rxd,
      xgmii_rxc           => xgmii_rxc,
      txp                 => txp,
      txn                 => txn,
      rxp                 => rxp,
      rxn                 => rxn,
      resetdone_out       => resetdone_out,
      signal_detect       => signal_detect,
      tx_fault            => tx_fault,
      drp_req             => drp_req,
      drp_gnt             => drp_gnt,
      drp_den_o           => drp_den_o,
      drp_dwe_o           => drp_dwe_o,
      drp_daddr_o         => drp_daddr_o,
      drp_di_o            => drp_di_o,
      drp_drdy_o          => drp_drdy_o,
      drp_drpdo_o         => drp_drpdo_o,
      drp_den_i           => drp_den_i,
      drp_dwe_i           => drp_dwe_i,
      drp_daddr_i         => drp_daddr_i,
      drp_di_i            => drp_di_i,
      drp_drdy_i          => drp_drdy_i,
      drp_drpdo_i         => drp_drpdo_i,
      tx_disable          => tx_disable,
      mdc                 => mdc,
      mdio_in             => mdio_in,
      mdio_out            => mdio_out,
      mdio_tri            => mdio_tri,
      prtad               => prtad,
      pma_pmd_type        => pma_pmd_type,
      core_status         => core_status);
end wrapper;



