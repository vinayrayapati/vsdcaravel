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
// Filename     	: aoi2222d1.v
// Description  	:  2/2/2/2 AND-OR-INVERT, 1X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module aoi2222d1 (A1,A2,B1,B2,C1,C2,D1,D2,ZN);

output  ZN;
input   A1,A2,B1,B2,C1,C2,D1,D2;

and (g_1_out,A2,A1);
and (g_2_out,B2,B1);
and (g_3_out,C2,C1);
and (g_4_out,D2,D1);
nor #1 (ZN,g_1_out,g_2_out,g_3_out,g_4_out);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a2_lh_zn_hl_2=0,a1_hl_zn_lh_2=0,a1_lh_zn_hl_2=0,a2_hl_zn_lh_2=0,
 b1_hl_zn_lh_1=0,b1_lh_zn_hl_1=0,b2_lh_zn_hl_2=0,b2_hl_zn_lh_2=0,c2_lh_zn_hl_10=0,
 c1_hl_zn_lh_10=0,c1_lh_zn_hl_10=0,c2_hl_zn_lh_10=0,d2_lh_zn_hl_1=0,d1_hl_zn_lh_1=0,
 d1_lh_zn_hl_1=0,d2_hl_zn_lh_10=0;
// Delays
 (        A2 -=> ZN) = (a2_hl_zn_lh_2,a2_lh_zn_hl_2);
 (        A1 -=> ZN) = (a1_hl_zn_lh_2,a1_lh_zn_hl_2);
 (        B1 -=> ZN) = (b1_hl_zn_lh_1,b1_lh_zn_hl_1);
 (        B2 -=> ZN) = (b2_hl_zn_lh_2,b2_lh_zn_hl_2);
 (        C2 -=> ZN) = (c2_hl_zn_lh_10,c2_lh_zn_hl_10);
 (        C1 -=> ZN) = (c1_hl_zn_lh_10,c1_lh_zn_hl_10);
 (        D2 -=> ZN) = (d2_hl_zn_lh_10,d2_lh_zn_hl_1);
 (        D1 -=> ZN) = (d1_hl_zn_lh_1,d1_lh_zn_hl_1);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
