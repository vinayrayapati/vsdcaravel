# vsdcaravel

## The Initial test run using RISCV GNU TOOL CHAIN

    <img width="564" alt="Screenshot 2023-02-09 at 11 37 53 AM" src="https://user-images.githubusercontent.com/110079631/217732125-68e52751-0724-4eec-a5bc-cb142c8b39a6.png">


## Adoption Challenges from sky130 to scl180

- **First Challenge:-** 
   1.  Modifying the Makefile to satify our requirements of porting from sky130 pdk to scl180 pdk. 
   2.  Changes made are the paths to the pdk files, verilog files, behavioural models.
   3.  Dfucntional is added in the sim defines since we want to deal with the functional model of verilog files instead of the gate level model netlists of sky130. The functional models make it easier for the porting of the technology node.
   4.  Any additional include paths are defined in the iverilog script of the makefile.
    
    <img width="638" alt="Screenshot 2023-02-27 at 10 13 32 AM" src="https://user-images.githubusercontent.com/110079631/221476303-36032c82-e3c1-4ff4-b7bf-06c9fe46c4af.png">
