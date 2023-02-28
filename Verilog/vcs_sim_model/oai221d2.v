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
// Filename     	: oai221d2.v
// Description  	:  2/2/1 OR-AND-INVERT, 2X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module oai221d2 (C1,C2,B1,B2,A,ZN);

output  ZN;
input   C1,C2,B1,B2,A;

or (g_2_out,C1,C2);
or (g_3_out,B2,B1);
nand #1 (ZN,A,g_2_out,g_3_out);

`ifdef functional
`else
specify
// Parameter declarations
 specparam c1_hl_zn_lh_2=0,c1_lh_zn_hl_2=0,b1_hl_zn_lh_2=0,b1_lh_zn_hl_2=0,
 b2_lh_zn_hl_2=0,a_hl_zn_lh_5=0,a_lh_zn_hl_5=0,b2_hl_zn_lh_2=0,c2_hl_zn_lh_2=0,c2_lh_zn_hl_3=0;
// Delays
 (        C1 -=> ZN) = (c1_hl_zn_lh_2,c1_lh_zn_hl_2);
 (        B1 -=> ZN) = (b1_hl_zn_lh_2,b1_lh_zn_hl_2);
 (        B2 -=> ZN) = (b2_hl_zn_lh_2,b2_lh_zn_hl_2);
 (        A  -=> ZN) = (a_hl_zn_lh_5,a_lh_zn_hl_5);
 (        C2 -=> ZN) = (c2_hl_zn_lh_2,c2_lh_zn_hl_3);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
