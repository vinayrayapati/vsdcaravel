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
// Filename     	: xn02d4.v
// Description  	:  2-Input Exclusive NOR, 4X Drive
// Library      	: tsl18fs120
// Programmer   	: ycui
// Date                 : 08-Oct-2003
// Product version	: Rev. main.1 
// Master version	: Rev. main.3
// STDP arcs            : 14Aug05 ben gilboa 
//


module xn02d4 (A1,A2,ZN);

output  ZN;
input   A1,A2;

xnor #1 (ZN,A2,A1);

`ifdef functional
`else
specify
// Parameter declarations
 specparam default_rise=0,default_fall=0;
// Delays
if (A2 == 1'b0)
	(A1 => ZN) = (default_rise,default_fall);
if (A2 == 1'b1)
	(A1 => ZN) = (default_rise,default_fall);
ifnone (A1 => ZN) = (default_rise,default_fall);
if (A1 == 1'b0)
	(A2 => ZN) = (default_rise,default_fall);
if (A1 == 1'b1)
	(A2 => ZN) = (default_rise,default_fall);
ifnone (A2 => ZN) = (default_rise,default_fall);
endspecify
`endif

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
