////////////////////////////////////////////////////////////////////
// Copyright (c) 2003 Synopsys, Inc.  All Rights Reserved       //
// This information is provided pursuant to a license agreement //
// that grants limited rights of access/use and requires that   //
// the information be treated as confidential.                  //
////////////////////////////////////////////////////////////////////

`celldefine
`suppress_faults
`enable_portfaults

`ifdef functional
 `timescale 1ns / 1ns
 `delay_mode_distributed
 `delay_mode_unit
`else
 `timescale 1ns / 1ps
 `delay_mode_path
`endif 


// Model type   	: zero timing
// Filename     	: senrb1.v
// Description  	:  Muxed Scan Enable D Flip-Flop, 1X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
// Added posedge to CP 
// at delay path        : 20Dec05 assafma & bengil 
// Added source to above : 29Jun06 tamasto
// Add `+` for veritime usage  : 11July06 tamasto

module senrb1 (CP,ENN,D,SC,SD,Q,QN);

output  Q,QN;
input   CP,ENN,D,SC,SD;

`ifdef neg_tchk
wire d_CP,d_ENN,d_D,d_SC,d_SD;
`endif

`ifdef functional
U_FD_SC_EN_P #1 (buf_Q,CP,ENN,SC,D,SD);
`else
reg notifier;
`ifdef neg_tchk
U_FD_SC_EN_P_NO #1 (buf_Q,d_CP,d_ENN,d_SC,d_D,d_SD,notifier);
`else
U_FD_SC_EN_P_NO #1 (buf_Q,CP,ENN,SC,D,SD,notifier);
`endif
`endif

buf (Q,buf_Q);
not (QN,buf_Q);

`ifdef functional
`else
`ifdef neg_tchk
buf (SC_buf,d_SC);
buf (ENN_buf,d_ENN);
`else
buf (SC_buf,SC);
buf (ENN_buf,ENN);
`endif

wire vcond1 = ((SC_buf==1'b0) && (ENN_buf==1'b0));
specify
// Parameter declarations
 specparam tsu_sd_h_cp=0.50,tsu_sd_l_cp=0.65,tsu_sc_h_cp=0.67,tsu_sc_l_cp=0.74,
 tsu_enn_h_cp=0.46,tsu_enn_l_cp=0.76,tsu_d_h_cp=0.35,tsu_d_l_cp=0.52,th_cp_sd_h=0.00,
 th_cp_sd_l=0.00,th_cp_sc_h=0.00,th_cp_sc_l=0.00,th_cp_enn_h=0.00,th_cp_enn_l=0.00,
 th_cp_d_h=0.00,th_cp_d_l=0.00,tpw_cp_h=0.20,tpw_cp_l=0.40,cp_lh_q_lh_1=0,cp_lh_q_hl_1=0,cp_lh_qn_hl_1=0,cp_lh_qn_lh_1=0;
// Violation constraints
 `ifdef neg_tchk
 $setuphold (posedge CP &&& (SC==1'b1),posedge SD &&& (SC==1'b1),tsu_sd_h_cp,th_cp_sd_l,notifier,,,d_CP,d_SD);
 $setuphold (posedge CP &&& (SC==1'b1),negedge SD &&& (SC==1'b1),tsu_sd_l_cp,th_cp_sd_h,notifier,,,d_CP,d_SD);
 $setuphold (posedge CP,posedge SC,tsu_sc_h_cp,th_cp_sc_l,notifier,,,d_CP,d_SC);
 $setuphold (posedge CP,negedge SC,tsu_sc_l_cp,th_cp_sc_h,notifier,,,d_CP,d_SC);
 $setuphold (posedge CP,posedge ENN &&& (SC==1'b0),tsu_enn_h_cp,th_cp_enn_l,notifier,,,d_CP,d_ENN);
 $setuphold (posedge CP,negedge ENN &&& (SC==1'b0),tsu_enn_l_cp,th_cp_enn_h,notifier,,,d_CP,d_ENN);
 $setuphold (posedge CP &&& (vcond1==1'b1),posedge D &&& (vcond1==1'b1),tsu_d_h_cp,th_cp_d_l,notifier,,,d_CP,d_D);
 $setuphold (posedge CP &&& (vcond1==1'b1),negedge D &&& (vcond1==1'b1),tsu_d_l_cp,th_cp_d_h,notifier,,,d_CP,d_D);
`else
$setup (posedge SD &&& (SC==1'b1),posedge CP &&& (SC==1'b1),tsu_sd_h_cp,notifier);
 $setup (negedge SD &&& (SC==1'b1),posedge CP &&& (SC==1'b1),tsu_sd_l_cp,notifier);
 $setup (posedge SC,posedge CP,tsu_sc_h_cp,notifier);
 $setup (negedge SC,posedge CP,tsu_sc_l_cp,notifier);
 $setup (posedge ENN &&& (SC==1'b0),posedge CP,tsu_enn_h_cp,notifier);
 $setup (negedge ENN &&& (SC==1'b0),posedge CP,tsu_enn_l_cp,notifier);
 $setup (posedge D &&& (vcond1==1'b1),posedge CP &&& (vcond1==1'b1),tsu_d_h_cp,notifier);
 $setup (negedge D &&& (vcond1==1'b1),posedge CP &&& (vcond1==1'b1),tsu_d_l_cp,notifier);
 $hold  (posedge CP &&& (SC==1'b1),negedge SD &&& (SC==1'b1),th_cp_sd_h,notifier);
 $hold  (posedge CP &&& (SC==1'b1),posedge SD &&& (SC==1'b1),th_cp_sd_l,notifier);
 $hold  (posedge CP,negedge SC,th_cp_sc_h,notifier);
 $hold  (posedge CP,posedge SC,th_cp_sc_l,notifier);
 $hold  (posedge CP,negedge ENN &&& (SC==1'b0),th_cp_enn_h,notifier);
 $hold  (posedge CP,posedge ENN &&& (SC==1'b0),th_cp_enn_l,notifier);
 $hold  (posedge CP &&& (vcond1==1'b1),negedge D &&& (vcond1==1'b1),th_cp_d_h,notifier);
 $hold  (posedge CP &&& (vcond1==1'b1),posedge D &&& (vcond1==1'b1),th_cp_d_l,notifier);
`endif
 $width (posedge CP,tpw_cp_h,0,notifier);
 $width (negedge CP,tpw_cp_l,0,notifier);
// Delays
 (posedge CP  => (Q +: D)) = (cp_lh_q_lh_1,cp_lh_q_hl_1);
 (posedge CP  => (QN +: D)) = (cp_lh_qn_lh_1,cp_lh_qn_hl_1);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
