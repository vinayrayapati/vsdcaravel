# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

PDK_PATH = $(PDK_ROOT)/scl018
#VERILOG_PATH = ../../../..
VERILOG_PATH = $(PDK_ROOT)/iolib/cio250/verilog/tsl18cio250/zero
RTL_PATH = $(VERILOG_PATH)/rtl
BEHAVIOURAL_MODELS = ../../ 
LIBRARY_VERILOG = $(PDK_ROOT)/stdlib/fs120/verilog/vcs_sim_model
FIRMWARE_PATH = ../..
GCC_PATH?=/ef/apps/bin
GCC_PREFIX?=riscv32-unknown-elf

SIM_DEFINES = -DFUNCTIONAL -DSIM

SIM?=RTL

.SUFFIXES:

PATTERN = hkspi

all:  ${PATTERN:=.vcd}

hex:  ${PATTERN:=.hex}

%.vvp: %_tb.v %.hex
ifeq ($(SIM),RTL)
	iverilog -Ttyp $(SIM_DEFINES) -I $(BEHAVIOURAL_MODELS) \
	-I $(PDK_PATH) -I $(LIBRARY_VERILOG) -I $(VERILOG_PATH) -I $(RTL_PATH) \
	$< -o $@ 
else  
	iverilog -Ttyp $(SIM_DEFINES) -DGL -I $(BEHAVIOURAL_MODELS) \
	-I $(PDK_PATH) -I $(VERILOG_PATH) -I $(RTL_PATH) \
	$< -o $@ 
endif

%.vcd: %.vvp
	vvp $<

%.elf: %.c $(FIRMWARE_PATH)/sections.lds $(FIRMWARE_PATH)/start.s check-env
	${GCC_PATH}/${GCC_PREFIX}-gcc -march=rv32im -mabi=ilp32 -Wl,-Bstatic,-T,$(FIRMWARE_PATH)/sections.lds,--strip-debug -ffreestanding -nostdlib -o $@ $(FIRMWARE_PATH)/start.s $<

%.hex: %.elf
	${GCC_PATH}/${GCC_PREFIX}-objcopy -O verilog $< $@ 
	# to fix flash base address
	sed -i '' 's/@10000000/@00000000/g' $@

%.bin: %.elf
	${GCC_PATH}/${GCC_PREFIX}-objcopy -O binary $< /dev/stdout | tail -c +1048577 > $@



check-env:
ifndef PDK_ROOT
	$(error PDK_ROOT is undefined, please export it before running make)
endif
ifeq (,$(wildcard $(PDK_ROOT)/scl018))
	$(error $(PDK_ROOT)/scl018 not found, please install pdk before running make)
endif
ifeq (,$(wildcard $(GCC_PATH)/$(GCC_PREFIX)-gcc ))
	$(error $(GCC_PATH)/$(GCC_PREFIX)-gcc is not found, please export GCC_PATH and GCC_PREFIX before running make)
endif
# check for efabless style installation
ifeq (,$(wildcard $(PDK_ROOT)/stdlib/fs120/verilog))
SIM_DEFINES := ${SIM_DEFINES} -DSCL
endif
# ---- Clean ----

clean:
	rm -f *.elf *.hex *.bin *.vvp *.vcd *.log

.PHONY: clean hex all


