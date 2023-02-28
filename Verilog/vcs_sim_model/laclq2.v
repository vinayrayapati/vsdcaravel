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
// Filename     	: laclq2.v
// Description  	:  Buffered Latch with Low Enable, Clear and Q only, 2X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module laclq2 (EN,D,CDN,Q);

output  Q;
input   EN,D,CDN;

`ifdef neg_tchk
wire d_EN,d_D,d_CDN;
`endif

`ifdef functional
U_LD_N_RB #1 (Q,D,EN,CDN);
`else
reg notifier;
`ifdef neg_tchk
U_LD_P_RB_NO #1 (Q,d_D,not_EN,d_CDN,notifier);
`else
U_LD_P_RB_NO #1 (Q,D,not_EN,CDN,notifier);
`endif
`endif

`ifdef functional
`else
`ifdef neg_tchk
not (not_EN,d_EN);
`else
not (not_EN,EN);
`endif
`endif

`ifdef functional
`else
specify
// Parameter declarations
 specparam tsu_d_h_en=0.28,tsu_d_l_en=0.23,tsu_cdn_h_en=0.28,th_en_d_h=0.00,
 th_en_d_l=0.00,th_en_cdn_l=0.00,tpw_en_l=0.32,tpw_cdn_l=0.31,cdn_lh_q_lh=0,
 d_hl_q_hl=0,d_lh_q_lh=0,en_hl_q_hl=0,cdn_hl_q_hl_2=0,en_hl_q_lh=0;
// Violation constraints
`ifdef neg_tchk
 $setuphold (posedge EN &&& (CDN==1'b1),posedge D &&& (CDN==1'b1),tsu_d_h_en,th_en_d_l,notifier,,,d_EN,d_D);
 $setuphold (posedge EN &&& (CDN==1'b1),negedge D &&& (CDN==1'b1),tsu_d_l_en,th_en_d_h,notifier,,,d_EN,d_D);
 $recrem (posedge CDN,posedge EN,tsu_cdn_h_en,th_en_cdn_l,notifier,,,d_CDN,d_EN);
`else
 $setup (posedge D &&& (CDN==1'b1),posedge EN &&& (CDN==1'b1),tsu_d_h_en,notifier);
 $setup (negedge D &&& (CDN==1'b1),posedge EN &&& (CDN==1'b1),tsu_d_l_en,notifier);
 $recovery (posedge CDN,posedge EN,tsu_cdn_h_en,notifier);
 $hold  (posedge EN &&& (CDN==1'b1),negedge D &&& (CDN==1'b1),th_en_d_h,notifier);
 $hold  (posedge EN &&& (CDN==1'b1),posedge D &&& (CDN==1'b1),th_en_d_l,notifier);
 $hold  (posedge EN,posedge CDN,th_en_cdn_l,notifier);
`endif
 $width (negedge EN &&& (CDN==1'b1),tpw_en_l,0,notifier);
 $width (negedge CDN,tpw_cdn_l,0,notifier);
// Delays
 (        CDN +=> Q) = (cdn_lh_q_lh,cdn_hl_q_hl_2);
 if ((EN==1'b0) && (CDN==1'b1))
 (        D   +=> Q) = (d_lh_q_lh,d_hl_q_hl);
 if (CDN==1'b1)
 (negedge EN   => (Q +: D   )) = (en_hl_q_lh,en_hl_q_hl);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
