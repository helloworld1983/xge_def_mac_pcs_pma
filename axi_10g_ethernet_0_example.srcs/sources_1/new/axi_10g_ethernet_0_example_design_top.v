`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2016 09:11:56 PM
// Design Name: 
// Module Name: axi_10g_ethernet_0_example_design_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axi_10g_ethernet_0_example_design_top
  (
   // Clock inputs
   input             clk_in_p,       // Freerunning clock source
   input             clk_in_n,
   input             refclk_p,       // Transceiver reference clock source
   input             refclk_n,

   // Serial I/O from/to transceiver
   output            txp,
   output            txn,
   input             rxp,
   input             rxn
  );

   wire              coreclk_out;

   // CUSTOMISED CONFIGURATOR
   wire [47:0]       dest_addr;
   wire [47:0]       src_addr;

   // Example design control inputs
   wire              pcs_loopback;
   wire              reset;
   wire              reset_error;
   wire              insert_error;
   wire              enable_pat_gen;
   wire              enable_pat_check;
   wire              serialized_stats;
   wire              sim_speedup_control;
   wire              enable_custom_preamble;

   // Example design status outputs
   wire              frame_error;
   wire              gen_active_flash;
   wire              check_active_flash;
   wire              core_ready;
   wire              qplllock_out;

   vio_0 vio(
      .clk                             (coreclk_out),
//      .probe_out0[7]                   (reset),
//      .probe_out0[6]                   (reset_error),
//      .probe_out0[5]                   (enable_pat_gen),
//      .probe_out0[4]                   (enable_pat_check),
//      .probe_out0[3]                   (pcs_loopback),
//      .probe_out0[2]                   (insert_error),
//      .probe_out0[1]                   (sim_speedup_control),
//      .probe_out0[0]                   (enable_custom_preamble),
      .probe_out0                      ({reset,
                                         reset_error,
                                         enable_pat_gen,
                                         enable_pat_check,
                                         pcs_loopback,
                                         insert_error,
                                         sim_speedup_control,
                                         enable_custom_preamble}),
      .probe_out1                      (src_addr),
      .probe_out2                      (dest_addr),

   // Example design status outputs
      .probe_in0                       ({core_ready,
                                         gen_active_flash,
                                         check_active_flash,
                                         frame_error,
                                         serialized_stats,
                                         qplllock_out})
   );

axi_10g_ethernet_0_example_design top
  (
   // Clock inputs
   .clk_in_p               (clk_in_p),       // Freerunning clock source
   .clk_in_n               (clk_in_n),
   .refclk_p               (refclk_p),       // Transceiver reference clock source
   .refclk_n               (refclk_n),
   .coreclk_out            (coreclk_out),

   // CUSTOMISED CONFIGURATOR
   .dest_addr              (dest_addr),
   .src_addr               (src_addr),

   // Example design control inputs
   .pcs_loopback           (pcs_loopback),
   .reset                  (reset),
   .reset_error            (reset_error),
   .insert_error           (insert_error),
   .enable_pat_gen         (enable_pat_gen),
   .enable_pat_check       (enable_pat_check),
   .serialized_stats       (serialized_stats),
   .sim_speedup_control    (sim_speedup_control),
   .enable_custom_preamble (enable_custom_preamble),

   // Example design status outputs
   .frame_error            (frame_error),
   .gen_active_flash       (gen_active_flash),
   .check_active_flash     (check_active_flash),
   .core_ready             (core_ready),
   .qplllock_out           (qplllock_out),

   // Serial I/O from/to transceiver
   .txp                    (txp),
   .txn                    (txn),
   .rxp                    (rxp),
   .rxn                    (rxn)
  );
  
endmodule