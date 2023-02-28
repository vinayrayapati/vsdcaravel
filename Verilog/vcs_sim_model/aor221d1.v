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
// Filename     	: aor221d1.v
// Description  	:  2/2/1 AND-OR, 1X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.4
//
//


module aor221d1 (C2,C1,B2,B1,A,Z);

output  Z;
input   C2,C1,B2,B1,A;

and (g_1_out,C1,C2);
and (g_2_out,B2,B1);
or #1 (Z,g_1_out,g_2_out,A);

`ifdef functional
`else
specify
// Parameter declarations
 specparam a_lh_z_lh_5=0,a_hl_z_hl_5=0,b2_lh_z_lh_2=0,b1_hl_z_hl_2=0,
 b1_lh_z_lh_2=0,b2_hl_z_hl_2=0,c2_lh_z_lh_1=0,c1_hl_z_hl_1=0,c1_lh_z_lh_1=0,c2_hl_z_hl_2=0;
// Delays
 (        A  +=> Z) = (a_lh_z_lh_5,a_hl_z_hl_5);
 (        B2 +=> Z) = (b2_lh_z_lh_2,b2_hl_z_hl_2);
 (        B1 +=> Z) = (b1_lh_z_lh_2,b1_hl_z_hl_2);
 (        C2 +=> Z) = (c2_lh_z_lh_1,c2_hl_z_hl_2);
 (        C1 +=> Z) = (c1_lh_z_lh_1,c1_hl_z_hl_1);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
