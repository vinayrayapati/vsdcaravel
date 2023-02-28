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
// Filename     	: aor21d2.v
// Description  	:  2/1 AND-OR, 2X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module aor21d2 (B2,B1,A,Z);

output  Z;
input   B2,B1,A;

and (g_1_out,B1,B2);
or #1 (Z,g_1_out,A);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a_lh_z_lh_2=0,a_hl_z_hl_2=0,b2_lh_z_lh=0,b1_hl_z_hl=0,
 b1_lh_z_lh=0,b2_hl_z_hl=0;
// Delays
 (        A  +=> Z) = (a_lh_z_lh_2,a_hl_z_hl_2);
 (        B2 +=> Z) = (b2_lh_z_lh,b2_hl_z_hl);
 (        B1 +=> Z) = (b1_lh_z_lh,b1_hl_z_hl);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
