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
// Filename     	: dfpfb1.v
// Description  	:  Buffered D Flip-Flop with Preset, 1X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module dfpfb1 (D,CPN,SDN,Q,QN);

output  Q,QN;
input   D,CPN,SDN;

`ifdef neg_tchk
wire d_D,d_CPN,d_SDN;
`endif

`ifdef functional
not (CPN_not,CPN);
U_FD_P_SB #1 (buf_Q,D,CPN_not,SDN);
`else
reg notifier;
`ifdef neg_tchk
U_FD_N_SB_NO #1 (buf_Q,d_D,d_CPN,d_SDN,notifier);
`else
U_FD_N_SB_NO #1 (buf_Q,D,CPN,SDN,notifier);
`endif
`endif

buf (Q,buf_Q);
not (QN,buf_Q);

`ifdef functional
`else
specify
// Parameter declarations
 specparam tsu_d_h_cpn=0.06,tsu_d_l_cpn=0.21,tsu_sdn_h_cpn=0.00,th_cpn_d_h=0.00,
 th_cpn_d_l=0.11,th_cpn_sdn_l=0.20,tpw_cpn_l=0.38,tpw_cpn_h=0.37,tpw_sdn_l=0.42,
 cpn_hl_qn_lh=0,cpn_hl_q_hl=0,cpn_hl_qn_hl=0,cpn_hl_q_lh=0,sdn_hl_qn_hl_2=0,sdn_hl_q_lh_2=0;
// Violation constraints
`ifdef neg_tchk
 $setuphold (negedge CPN &&& (SDN==1'b1),posedge D &&& (SDN==1'b1),tsu_d_h_cpn,th_cpn_d_l,notifier,,,d_CPN,d_D);
 $setuphold (negedge CPN &&& (SDN==1'b1),negedge D &&& (SDN==1'b1),tsu_d_l_cpn,th_cpn_d_h,notifier,,,d_CPN,d_D);
 $recrem (posedge SDN,negedge CPN,tsu_sdn_h_cpn,th_cpn_sdn_l,notifier,,,d_SDN,d_CPN);
`else 
 $setup (posedge D &&& (SDN==1'b1),negedge CPN &&& (SDN==1'b1),tsu_d_h_cpn,notifier);
 $setup (negedge D &&& (SDN==1'b1),negedge CPN &&& (SDN==1'b1),tsu_d_l_cpn,notifier);
 $recovery (posedge SDN,negedge CPN,tsu_sdn_h_cpn,notifier);
 $hold  (negedge CPN &&& (SDN==1'b1),negedge D &&& (SDN==1'b1),th_cpn_d_h,notifier);
 $hold  (negedge CPN &&& (SDN==1'b1),posedge D &&& (SDN==1'b1),th_cpn_d_l,notifier);
 $hold  (negedge CPN,posedge SDN,th_cpn_sdn_l,notifier);
`endif
 $width (negedge CPN &&& (SDN==1'b1),tpw_cpn_l,0,notifier);
 $width (posedge CPN &&& (SDN==1'b1),tpw_cpn_h,0,notifier);
 $width (negedge SDN,tpw_sdn_l,0,notifier);
// Delays
 if (SDN==1'b1)
 (negedge CPN  => (QN -: D   )) = (cpn_hl_qn_lh,cpn_hl_qn_hl);
 if (SDN==1'b1)
 (negedge CPN  => (Q  +: D   )) = (cpn_hl_q_lh,cpn_hl_q_hl);
 (negedge SDN  => (QN -: 1'b1)) = (0,sdn_hl_qn_hl_2);
 (negedge SDN  => (Q  +: 1'b1)) = (sdn_hl_q_lh_2,0);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
