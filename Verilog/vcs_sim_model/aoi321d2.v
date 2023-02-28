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
// Filename     	: aoi321d2.v
// Description  	:  3/2/1 AND-OR-INVERT, 2X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module aoi321d2 (C3,C2,C1,B2,B1,A,ZN);

output  ZN;
input   C3,C2,C1,B2,B1,A;

and (g_1_out,C3,C2,C1);
and (g_2_out,B1,B2);
nor #1 (ZN,g_1_out,g_2_out,A);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a_lh_zn_hl_11=0,a_hl_zn_lh_11=0,b2_lh_zn_hl_4=0,b1_hl_zn_lh_4=0,
 b1_lh_zn_hl_4=0,b2_hl_zn_lh_4=0,c3_lh_zn_hl_1=0,c2_hl_zn_lh_1=0,c2_lh_zn_hl_1=0,
 c1_hl_zn_lh_1=0,c1_lh_zn_hl_2=0,c3_hl_zn_lh_2=0;
// Delays
 (        A  -=> ZN) = (a_hl_zn_lh_11,a_lh_zn_hl_11);
 (        B2 -=> ZN) = (b2_hl_zn_lh_4,b2_lh_zn_hl_4);
 (        B1 -=> ZN) = (b1_hl_zn_lh_4,b1_lh_zn_hl_4);
 (        C3 -=> ZN) = (c3_hl_zn_lh_2,c3_lh_zn_hl_1);
 (        C2 -=> ZN) = (c2_hl_zn_lh_1,c2_lh_zn_hl_1);
 (        C1 -=> ZN) = (c1_hl_zn_lh_1,c1_lh_zn_hl_2);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
