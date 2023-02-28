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
// Filename     	: nr04d0.v
// Description          : 4-Input NOR, 0.5X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.5
//
//


module nr04d0 (A1,A2,A3,A4,ZN);

output  ZN;
input   A1,A2,A3,A4;

nor #1 (ZN,A4,A3,A2,A1);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a1_lh_zn_hl=0,a1_hl_zn_lh=0,a2_lh_zn_hl=0,a2_hl_zn_lh=0,
 a3_lh_zn_hl=0,a3_hl_zn_lh=0,a4_lh_zn_hl=0,a4_hl_zn_lh=0;
// Delays
 (        A1 -=> ZN) = (a1_hl_zn_lh,a1_lh_zn_hl);
 (        A2 -=> ZN) = (a2_hl_zn_lh,a2_lh_zn_hl);
 (        A3 -=> ZN) = (a3_hl_zn_lh,a3_lh_zn_hl);
 (        A4 -=> ZN) = (a4_hl_zn_lh,a4_lh_zn_hl);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
