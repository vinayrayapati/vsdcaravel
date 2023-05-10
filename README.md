# vsdcaravel

# Table of contents
 - [1.The Initial test run using RISCV GNU TOOL CHAIN](#1-The-Initial-test-run-using-RISCV-GNU-TOOL-CHAIN)
 - [2.Adoption Challenges from sky130 to scl180](#2-Adoption-Challenges-from-sky130-to-scl180)

## 1. The Initial test run using RISCV GNU TOOL CHAIN

<img width="743" alt="Screenshot 2023-02-27 at 6 33 55 PM" src="https://user-images.githubusercontent.com/110079631/221571215-24b8c4c6-c268-4c32-8105-a15ea9f60e90.png">

## 2. Steps to follow:-

<b> Change the paths of `PDK_ROOT`, `PDK`, `GCC_PATH` and `GCC_PREFIX` according to the paths on the system you are working on. </b>

Steps to follow :

```
$ git clone https://github.com/DantuNandiniDevi/Caravel_pcb

$ cd Caravel_pcb/verification/verilog/dv/caravel/mgmt_soc/hkspi

$ export PDK_ROOT= <scl_pdk_v2 path>

$ export PDK=scl018

$ export GCC_PATH=/opt/homebrew/Cellar/riscv-gnu-toolchain/main/bin

$ export GCC_PREFIX=riscv64-unknown-elf

$ make 

$ gtkwave hkspi.vcd 

``` 


## 3. Adoption Challenges from sky130 to scl180

- **First Challenge:-** 
   1.  Modifying the Makefile to satify our requirements of porting from sky130 pdk to scl180 pdk. 
   2.  Changes made are the paths to the pdk files, verilog files, behavioural models.
   3.  Dfucntional is added in the sim defines since we want to deal with the functional model of verilog files instead of the gate level model netlists of sky130. The functional models make it easier for the porting of the technology node.
   4.  Any additional include paths are defined in the iverilog script of the makefile.
    
    - Makefile
     
      <img width="638" alt="Screenshot 2023-02-27 at 10 13 32 AM" src="https://user-images.githubusercontent.com/110079631/221476303-36032c82-e3c1-4ff4-b7bf-06c9fe46c4af.png">
    
- **Second Challenge:-**
    1.  Identifying the similar counterparts of sky130 IO's in scl IO library.
    2.  This can be achieved by comparing the IO specifications provided in the scl IO library.
    3.  Next, we need to replace the IO's both general purpose and power IO's in sky130 with their equal couterpart scl180 verilog module instantiations by including them in the caraval_netlists.v.
    4.  The verilog files for the scl IO's are available in the IO lib.
    5.  We choose tsl18cio250 model of IO due to the Nominal Voltage requirements.
    
    - The IO verilog files:
    
        <img width="571" alt="Screenshot 2023-02-27 at 1 32 27 PM" src="https://user-images.githubusercontent.com/110079631/221507255-e5298ffe-d5eb-40fe-842e-cba2fb994410.png">
    
    - The Docs useful in identifying the IO counterparts:
    
        <img width="368" alt="Screenshot 2023-02-27 at 1 34 12 PM" src="https://user-images.githubusercontent.com/110079631/221507506-05d0e588-ad6b-48d0-80f2-c8fac4a3613b.png">

    - Including the verilog files in caravel_netlists.v
    
        <img width="387" alt="Screenshot 2023-02-27 at 1 35 35 PM" src="https://user-images.githubusercontent.com/110079631/221507764-ab86aa99-591b-4a0f-b914-b3ae19180068.png">

    - Replacing the sky130 instantiations
    
        <img width="625" alt="Screenshot 2023-02-27 at 1 36 49 PM" src="https://user-images.githubusercontent.com/110079631/221507967-1456c79d-1366-4cca-a465-24a53a50dc63.png">
        
    - The Errors for the instantiations to be replaced with scl verilog modules and eliminated in a stepwise manner.
        - First Modification
        
            ![WhatsApp Image 2023-02-14 at 1 36 46 PM](https://user-images.githubusercontent.com/110079631/221511624-85f2d5ae-a9dd-4571-9ca6-968c02baf0ed.jpeg)
        
        - Second Modification
        
            ![WhatsApp Image 2023-02-17 at 6 14 22 PM](https://user-images.githubusercontent.com/110079631/221511738-3dbbb1b2-8c31-4881-a8ac-83a619223bc8.jpeg)

        - Third Modification
        
            <img width="447" alt="Screenshot 2023-02-20 at 12 15 34 PM" src="https://user-images.githubusercontent.com/110079631/221513151-fb2c2046-b20b-45e4-9ff9-3fd4987db9f8.png">


- **Third Challenge:-**
    1. Identifying the similar counterparts of sky130 logic blocks in scl std library.
    2. This can be achieved by comparing the logic specifications provided in the scl std library.
    3. Next, we need to replace the logic blocks both combinational and sequential in sky130 with their equal couterpart scl180 verilog module instantiations by including them in the caraval_netlists.v.
    4. The verilog files for the scl logic blocks are available in the scl std lib.
    
    - The Logic block(D FF) verilog files
    
        <img width="560" alt="Screenshot 2023-02-27 at 1 39 58 PM" src="https://user-images.githubusercontent.com/110079631/221508647-35c34b03-7c7d-4bce-b6f5-1f10155d05a0.png">

    - The Comments in the verilog files used to identify the behaviour
    
        <img width="614" alt="Screenshot 2023-02-27 at 1 57 47 PM" src="https://user-images.githubusercontent.com/110079631/221512191-aec03aa5-3083-4eed-bdfd-e839049f61c5.png">

    - Including the verilog files in caravel_netlists.v
    
        <img width="276" alt="Screenshot 2023-02-27 at 1 58 27 PM" src="https://user-images.githubusercontent.com/110079631/221512334-2dceffb6-f50f-455d-ac46-4ef1976a9611.png">

    - Writing verilog modules in templates similar to that of sky130 to those logic blocks which are missing in the scl library and including them in the caravel netlists.v verilog file
    
        <img width="591" alt="Screenshot 2023-02-27 at 2 00 12 PM" src="https://user-images.githubusercontent.com/110079631/221512635-302083ac-f873-4df9-977d-cf65ba991b6a.png">
    
    - The Errors for the instantiations to be replaced with scl verilog modules and eliminated in a stepwise manner.
        - First Modification
        
            <img width="437" alt="Screenshot 2023-02-22 at 8 58 50 AM" src="https://user-images.githubusercontent.com/110079631/221513206-5a3d243f-79d4-4068-8901-4e7f13b73999.png">

        - Second Modification
        
            <img width="425" alt="Screenshot 2023-02-25 at 1 24 41 PM" src="https://user-images.githubusercontent.com/110079631/221513328-f92081ed-b5fc-40db-9f6d-5e8015750c04.png">

        - Third Modification
        
            <img width="456" alt="Screenshot 2023-02-25 at 1 24 58 PM" src="https://user-images.githubusercontent.com/110079631/221513412-00b40649-2b82-41fe-9392-4c24bb21b6fa.png">

        - Fourth Modification
        
            <img width="439" alt="Screenshot 2023-02-25 at 1 25 10 PM" src="https://user-images.githubusercontent.com/110079631/221513499-acc9219e-a6de-4762-972c-faf7601253b2.png">


- **Fourth Challenge:-**
**(post Mid-term)**

Identify the nets that are left unbinded and declare them as wires in the file tsl18fs120_scl.v for various combinational circuit modules from the lines 2000 to the line 15,000.

- At Lines 600:-

   <img width="1512" alt="Screenshot 2023-03-14 at 10 47 32 AM" src="https://user-images.githubusercontent.com/110079631/225524806-9d613f5c-050c-490f-8ef4-6d1c4663f752.png">

- At Lines 10,000:-

   <img width="1512" alt="Screenshot 2023-03-14 at 11 05 36 AM" src="https://user-images.githubusercontent.com/110079631/225524862-b323724f-ae81-4d08-becf-d05ca4e11975.png">

- At Lines 11,000:-

   <img width="1512" alt="Screenshot 2023-03-14 at 11 22 56 AM" src="https://user-images.githubusercontent.com/110079631/225524935-9bd01433-e5fb-43e5-93a3-d484f9379011.png">

- At Lines 12,000:-

   <img width="1512" alt="Screenshot 2023-03-14 at 11 24 24 AM" src="https://user-images.githubusercontent.com/110079631/225524957-bce7f19a-afac-423e-a24d-e1839c40cbec.png">

- At Lines 13,000:-

   <img width="1512" alt="Screenshot 2023-03-14 at 11 30 57 AM" src="https://user-images.githubusercontent.com/110079631/225525098-6f5943b3-2aa1-419f-8f78-448454a140f1.png">

- At Lines 14,000:-

   <img width="1512" alt="Screenshot 2023-03-14 at 11 32 39 AM" src="https://user-images.githubusercontent.com/110079631/225525138-bea9637f-2493-4765-a454-678fc46f3226.png">

- At Lines 15,000:-

   <img width="1512" alt="Screenshot 2023-03-14 at 11 35 57 AM" src="https://user-images.githubusercontent.com/110079631/225525161-c170be7e-8388-480d-9480-1b9bcf1d5c44.png">


- **Fifth Challenge:-**

Identifying the difference in the ports declared in the firmware verilog files and the scl verilog files and modify them accordingly.

- 1.
    <img width="1512" alt="Screenshot 2023-03-14 at 11 37 46 AM" src="https://user-images.githubusercontent.com/110079631/225525243-43610f15-f230-4e21-b46c-ca36ab7505c0.png">

- 2.
    <img width="1512" alt="Screenshot 2023-03-14 at 11 38 07 AM" src="https://user-images.githubusercontent.com/110079631/225525267-81558290-327c-423f-b7fc-7ebd204b7f82.png">

- **Sixth Challenge:-**

**Power pins errors**
Identifying the unnecessary power pins at this stage that are not required as they can be synthesized later to avoid the errors in the simulation at this stage.

1. Power pin errors in macro_spare_cell module:
    
    <img width="1512" alt="Screenshot 2023-04-19 at 2 31 05 PM" src="https://user-images.githubusercontent.com/110079631/233271060-a3aada4d-6756-4d89-a06c-154e4b69de1f.png">

2. Power pin errors in housekeeping module:

    <img width="1286" alt="Screenshot 2023-04-19 at 2 31 31 PM" src="https://user-images.githubusercontent.com/110079631/233271087-070a4100-5697-4f9f-85e1-bd54c706c055.png">

3. Power pin errors in digital_pll module:

    <img width="1224" alt="Screenshot 2023-04-19 at 2 31 40 PM" src="https://user-images.githubusercontent.com/110079631/233271116-0c91303f-1481-45c4-b12a-0645f9a304b4.png">

4. Power pin errors in mgmt_protect module:

    <img width="1309" alt="Screenshot 2023-04-19 at 2 31 59 PM" src="https://user-images.githubusercontent.com/110079631/233271135-6e68ea09-1b29-4990-a958-787131395aea.png">

5. Power pin errors in mgmt_protect_hv module:

    <img width="1329" alt="Screenshot 2023-04-19 at 2 32 09 PM" src="https://user-images.githubusercontent.com/110079631/233271157-a5134ef4-b26c-400b-9c32-22c43d111eb3.png">

6. Power pin errors in mgmt_core module:

    <img width="1217" alt="Screenshot 2023-04-19 at 2 32 20 PM" src="https://user-images.githubusercontent.com/110079631/233271175-e9a5ebc3-46ba-43f7-84a3-1b6cd3019622.png">

7. Power pin errors in mprj_io module:

    <img width="1265" alt="Screenshot 2023-04-19 at 2 32 30 PM" src="https://user-images.githubusercontent.com/110079631/233271208-5c93fb7c-9cc8-46d8-992b-159fa13eb263.png">

8. Power pin errors in simple_por module:

    <img width="1252" alt="Screenshot 2023-04-19 at 2 33 20 PM" src="https://user-images.githubusercontent.com/110079631/233271234-82269605-eda2-4726-8f74-8729b224c30f.png">

9. Power pin errors in xres_buf module:

    <img width="1190" alt="Screenshot 2023-04-19 at 2 34 01 PM" src="https://user-images.githubusercontent.com/110079631/233271256-a9c8ae69-6a03-4290-8a9b-9c9b27c4d934.png">

10. Power pin errors in gpio_default_blocks module:

    <img width="1320" alt="Screenshot 2023-04-19 at 2 36 22 PM" src="https://user-images.githubusercontent.com/110079631/233271286-822bc2b2-7a8d-4229-bd8f-3e2852bce398.png">

11. Power pin errors in chip_io module:

     <img width="1248" alt="Screenshot 2023-04-19 at 2 36 44 PM" src="https://user-images.githubusercontent.com/110079631/233271307-f1588944-5551-4ff6-801c-a332ebb9d355.png">

12. Power pin errors in constant_block module:

     <img width="1257" alt="Screenshot 2023-04-19 at 2 37 02 PM" src="https://user-images.githubusercontent.com/110079631/233271330-9ca044b4-40dd-4b57-8742-2dbf3c75af03.png">

13. Power pin errors in gpio_signal_buffering module:

     <img width="1324" alt="Screenshot 2023-04-19 at 2 37 12 PM" src="https://user-images.githubusercontent.com/110079631/233271353-8dec1829-a6e3-4ea0-b0d9-84bce0b9eb10.png">

14. Power pin errors in chip_io module:

     - <img width="1248" alt="Screenshot 2023-04-19 at 2 37 39 PM" src="https://user-images.githubusercontent.com/110079631/233271373-452965c6-8de9-4d84-8cff-8167c1e4a6fa.png">

     - <img width="1357" alt="Screenshot 2023-04-19 at 2 37 53 PM" src="https://user-images.githubusercontent.com/110079631/233271392-89603e0e-f571-4686-a799-e182c71f8976.png">

- **Results after a successfull porting from sky130 to scl180**

This is the final output obtained after succesfully eliminating all the porting errors and power pin errors:

   - <img width="407" alt="Screenshot 2023-04-25 at 11 32 50 AM" src="https://github.com/vinayrayapati/vsdcaravel/assets/110079631/e0933126-0543-4097-8ce5-84e6cd97081e">

- **Future Work Left**

- Rectify the simulation mismatches seen now by backtracing the signals.


### Author
 - **Vinay Rayapati**

### Contributors
 - Vinay Rayapati
 - Kunal Ghosh

### Acknowledgments
 - Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
 - Dr.Madhav Rao, ECE Department, IIIT Bangalore.

### References
 - SCL PDK
 - EFabless

### Contact Information
 - Vinay Rayapati,Post-Graduate student,International Institute of Information Technology Bangalore,vinayrayapati@outlook.com
 - Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.,kunalghosh@gmail.com
 - Dr.Madhav Rao, ECE Department, IIIT Bangalore,mr@iiitb.ac.in
