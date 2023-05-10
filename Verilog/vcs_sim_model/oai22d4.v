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
// Filename     	: oai22d4.v
// Description  	:  2/2 OR-AND-INVERT, 4X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module oai22d4 (A1,A2,B1,B2,ZN);

output  ZN;
input   A1,A2,B1,B2;

or (g_1_out,B2,B1);
or (g_2_out,A2,A1);
nand #1 (ZN,g_1_out,g_2_out);

`ifdef functional
`else
specify
// Parameter declarations
 specparam b1_hl_zn_lh_2=0,b1_lh_zn_hl_2=0,a1_hl_zn_lh_2=0,a1_lh_zn_hl_2=0,
 a2_lh_zn_hl_2=0,a2_hl_zn_lh_2=0,b2_hl_zn_lh_2=0,b2_lh_zn_hl_3=0;
// Delays
 (        B1 -=> ZN) = (b1_hl_zn_lh_2,b1_lh_zn_hl_2);
 (        A1 -=> ZN) = (a1_hl_zn_lh_2,a1_lh_zn_hl_2);
 (        A2 -=> ZN) = (a2_hl_zn_lh_2,a2_lh_zn_hl_2);
 (        B2 -=> ZN) = (b2_hl_zn_lh_2,b2_lh_zn_hl_3);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults