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
// Filename     	: oaim211d4.v
// Description  	:  2/1/1 OR-AND-INVERT with C Inputs Inverted, 4X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module oaim211d4 (C2,C1,B,A,ZN);

output  ZN;
input   C2,C1,B,A;

buf (C2_buf,C2);
buf (C1_buf,C1);
buf (B_buf,B);
buf (A_buf,A);

wire ZN_OUT = !((B_buf && A_buf && !C2_buf) || (B_buf && A_buf && !C1_buf));

buf #1 (ZN,ZN_OUT);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a_lh_zn_hl_1=0,a_hl_zn_lh_1=0,b_hl_zn_lh_1=0,b_lh_zn_hl_1=0,
 c1_lh_zn_lh=0,c1_hl_zn_hl=0,c2_hl_zn_hl=0,c2_lh_zn_lh=0;
// Delays
 (        A  -=> ZN) = (a_hl_zn_lh_1,a_lh_zn_hl_1);
 (        B  -=> ZN) = (b_hl_zn_lh_1,b_lh_zn_hl_1);
 (        C1 +=> ZN) = (c1_lh_zn_lh,c1_hl_zn_hl);
 (        C2 +=> ZN) = (c2_lh_zn_lh,c2_hl_zn_hl);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
