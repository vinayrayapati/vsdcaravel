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
// Filename     	: depfq2.v
// Description  	:  Buffered Enabled D Flip-Flop with Preset and Q only, 2X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module depfq2 (CPN,SDN,D,ENN,Q);

output  Q;
input   CPN,SDN,D,ENN;

`ifdef neg_tchk
wire d_CPN,d_SDN,d_D,d_ENN;
`endif

`ifdef functional
`else
`ifdef neg_tchk
buf (SDN_buf,d_SDN);
buf (D_buf,d_D);
buf (ENN_buf,d_ENN);
`else
buf (SDN_buf,SDN);
buf (D_buf,D);
buf (ENN_buf,ENN);
`endif
`endif

`ifdef functional
U_FD_EN_N_SB #1 (Q,CPN,ENN,SDN,D);
`else
reg notifier;
`ifdef neg_tchk
U_FD_EN_N_SB_NO #1 (Q,d_CPN,d_ENN,d_SDN,d_D,notifier);
`else
U_FD_EN_N_SB_NO #1 (Q,CPN,ENN,SDN,D,notifier);
`endif
`endif

`ifdef functional
`else
wire BOOL_OUT = (((!ENN_buf && D_buf)) && ((!ENN_buf))) || !(!Q || ((!ENN_buf)));
wire vcond1 = ((SDN_buf==1'b1) && (ENN_buf==1'b0));
specify
// Parameter declarations
 specparam tsu_enn_h_cpn=0.24,tsu_enn_l_cpn=0.45,tsu_d_h_cpn=0.26,tsu_d_l_cpn=0.36,
 tsu_sdn_h_cpn=0.00,th_cpn_enn_h=0.00,th_cpn_enn_l=0.00,th_cpn_d_h=0.00,th_cpn_d_l=0.00,
 th_cpn_sdn_l=0.14,tpw_cpn_l=0.37,tpw_cpn_h=0.32,tpw_sdn_l=0.32,cpn_hl_q_hl=0,
 cpn_hl_q_lh=0,sdn_hl_q_lh_2=0;
// Violation constraints
`ifdef neg_tchk
 $setuphold (negedge CPN &&& (SDN==1'b1),posedge ENN &&& (SDN==1'b1),tsu_enn_h_cpn,th_cpn_enn_l,notifier,,,d_CPN,d_ENN);
 $setuphold (negedge CPN &&& (SDN==1'b1),negedge ENN &&& (SDN==1'b1),tsu_enn_l_cpn,th_cpn_enn_h,notifier,,,d_CPN,d_ENN);
 $setuphold (negedge CPN &&& (vcond1==1'b1),posedge D &&& (vcond1==1'b1),tsu_d_h_cpn,th_cpn_d_l,notifier,,,d_CPN,d_D);
 $setuphold (negedge CPN &&& (vcond1==1'b1),negedge D &&& (vcond1==1'b1),tsu_d_l_cpn,th_cpn_d_h,notifier,,,d_CPN,d_D);
 $recrem (posedge SDN &&& (ENN==1'b0),negedge CPN &&& (ENN==1'b0),tsu_sdn_h_cpn,th_cpn_sdn_l,notifier,,,d_SDN,d_CPN);
`else
 $setup (posedge ENN &&& (SDN==1'b1),negedge CPN &&& (SDN==1'b1),tsu_enn_h_cpn,notifier);
 $setup (negedge ENN &&& (SDN==1'b1),negedge CPN &&& (SDN==1'b1),tsu_enn_l_cpn,notifier);
 $setup (posedge D &&& (vcond1==1'b1),negedge CPN &&& (vcond1==1'b1),tsu_d_h_cpn,notifier);
 $setup (negedge D &&& (vcond1==1'b1),negedge CPN &&& (vcond1==1'b1),tsu_d_l_cpn,notifier);
 $recovery (posedge SDN &&& (ENN==1'b0),negedge CPN &&& (ENN==1'b0),tsu_sdn_h_cpn,notifier);
 $hold  (negedge CPN &&& (SDN==1'b1),negedge ENN &&& (SDN==1'b1),th_cpn_enn_h,notifier);
 $hold  (negedge CPN &&& (SDN==1'b1),posedge ENN &&& (SDN==1'b1),th_cpn_enn_l,notifier);
 $hold  (negedge CPN &&& (vcond1==1'b1),negedge D &&& (vcond1==1'b1),th_cpn_d_h,notifier);
 $hold  (negedge CPN &&& (vcond1==1'b1),posedge D &&& (vcond1==1'b1),th_cpn_d_l,notifier);
 $hold  (negedge CPN &&& (ENN==1'b0),posedge SDN &&& (ENN==1'b0),th_cpn_sdn_l,notifier);
`endif
 $width (negedge CPN &&& (vcond1==1'b1),tpw_cpn_l,0,notifier);
 $width (posedge CPN &&& (vcond1==1'b1),tpw_cpn_h,0,notifier);
 $width (negedge SDN,tpw_sdn_l,0,notifier);
// Delays
 if ((SDN==1'b1) && (ENN==1'b0))
 (negedge CPN  => (Q +: BOOL_OUT)) = (cpn_hl_q_lh,cpn_hl_q_hl);
 (negedge SDN  => (Q +: 1'b1)) = (sdn_hl_q_lh_2,0);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
