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
// Filename     	: ora31d1.v
// Description  	:  3/1 OR-AND, 1X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module ora31d1 (B3,B2,B1,A,Z);

output  Z;
input   B3,B2,B1,A;

or (g_2_out,B2,B1,B3);
and #1 (Z,A,g_2_out);

`ifdef functional
`else
specify
// Parameter declarations
 specparam b1_hl_z_hl=0,b1_lh_z_lh=0,b2_lh_z_lh=0,a_hl_z_hl_2=0,
 b2_hl_z_hl=0,b3_lh_z_lh=0,a_lh_z_lh_4=0,b3_hl_z_hl=0;
// Delays
 (        B1 +=> Z) = (b1_lh_z_lh,b1_hl_z_hl);
 (        B2 +=> Z) = (b2_lh_z_lh,b2_hl_z_hl);
 (        A  +=> Z) = (a_lh_z_lh_4,a_hl_z_hl_2);
 (        B3 +=> Z) = (b3_lh_z_lh,b3_hl_z_hl);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
