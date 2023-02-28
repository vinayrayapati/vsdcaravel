// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`timescale 1 ns / 1 ps

`define UNIT_DELAY #1
`define USE_POWER_PINS

`ifdef SIM

    `include "defines.v"
    `include "user_defines.v"
    `include "pads.v"

	`include "pvda.v"
	`include "pv0a.v"
	`include "apv0a.v"
	`include "apvda.v"
	`include "pvdi.v"
	`include "pv0i.v" 
	`include "pc3d01.v"
	`include "pc3b01.v"
	`include "pc3o01.v"
	// `include "invtd1.v"
	// `include "inv0d0.v"
	// `include "buffd1.v"
	// `include "nd02d0.v"
	// `include "nr02d0.v"
	// `include "dfbrb1.v"
	`include "schmitt_buf.v"
	`include "lsbuf.v"
	`include "tap.v"
	`include "diode.v"
	`include "decap.v"
	`include "macro_sparecell.v"
	`include "conb.v"
	`include "tsl18fs120_scl.v"
	`include "scl_corner_pad.v"
    /* NOTE: Need to pass the PDK root directory to iverilog with option -I */

     `ifdef GL

    `else
	`include "buff_flash_clkrst.v"
	`include "digital_pll.v"
	`include "digital_pll_controller.v"
	`include "ring_osc2x13.v"
	`include "caravel_clocking.v"
	`include "user_id_programming.v"
	`include "clock_div.v"
	`include "mprj_io.v"
	`include "chip_io.v"
	`include "debug_regs.v"
	`include "housekeeping_spi.v"
	`include "housekeeping.v"
	`include "mprj_logic_high.v"
	`include "mprj2_logic_high.v"
	`include "mgmt_protect.v"
	`include "mgmt_protect_hv.v"
	`include "constant_block.v"
	`include "gpio_control_block.v"
	`include "gpio_defaults_block.v"
	`include "gpio_signal_buffering.v"
	`include "gpio_logic_high.v"
	`include "xres_buf.v"
	`include "spare_logic_block.v"
	`include "mgmt_core_wrapper.v"
	`include "mgmt_core.v"
	`include "VexRiscv_LiteDebug.v"
	// `include "RAM128.v"
	`include "caravel.v"
     `endif

    `include "simple_por.v"

`endif
