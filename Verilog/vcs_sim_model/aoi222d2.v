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
// Filename     	: aoi222d2.v
// Description  	:  2/2/2 AND-OR-INVERT, 2X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module aoi222d2 (A1,A2,B1,B2,C1,C2,ZN);

output  ZN;
input   A1,A2,B1,B2,C1,C2;

and (g_1_out,A2,A1);
and (g_2_out,B2,B1);
and (g_3_out,C2,C1);
nor #1 (ZN,g_1_out,g_2_out,g_3_out);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a2_lh_zn_hl_5=0,a1_hl_zn_lh_5=0,a1_lh_zn_hl_5=0,a2_hl_zn_lh_5=0,
 b2_lh_zn_hl_4=0,b1_hl_zn_lh_4=0,b1_lh_zn_hl_4=0,b2_hl_zn_lh_5=0,c1_lh_zn_hl_1=0,
 c1_hl_zn_lh_5=0,c2_lh_zn_hl_2=0,c2_hl_zn_lh_5=0;
// Delays
 (        A2 -=> ZN) = (a2_hl_zn_lh_5,a2_lh_zn_hl_5);
 (        A1 -=> ZN) = (a1_hl_zn_lh_5,a1_lh_zn_hl_5);
 (        B2 -=> ZN) = (b2_hl_zn_lh_5,b2_lh_zn_hl_4);
 (        B1 -=> ZN) = (b1_hl_zn_lh_4,b1_lh_zn_hl_4);
 (        C1 -=> ZN) = (c1_hl_zn_lh_5,c1_lh_zn_hl_1);
 (        C2 -=> ZN) = (c2_hl_zn_lh_5,c2_lh_zn_hl_2);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
