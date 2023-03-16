# vsdcaravel

# Table of contents
 - [1.The Initial test run using RISCV GNU TOOL CHAIN](#1-The-Initial-test-run-using-RISCV-GNU-TOOL-CHAIN)
 - [2.Adoption Challenges from sky130 to scl180](#2-Adoption-Challenges-from-sky130-to-scl180)

## 1. The Initial test run using RISCV GNU TOOL CHAIN

<img width="743" alt="Screenshot 2023-02-27 at 6 33 55 PM" src="https://user-images.githubusercontent.com/110079631/221571215-24b8c4c6-c268-4c32-8105-a15ea9f60e90.png">

## 2. Adoption Challenges from sky130 to scl180

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
(post Mid-term)

Identify the nets that are left unbinded and declare them as wires in the file tsl18fs120_scl.v for various combinational circuit modules from the lines 2000 to the line 15,000.


<img width="1512" alt="Screenshot 2023-03-14 at 10 47 32 AM" src="https://user-images.githubusercontent.com/110079631/225524806-9d613f5c-050c-490f-8ef4-6d1c4663f752.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 05 36 AM" src="https://user-images.githubusercontent.com/110079631/225524862-b323724f-ae81-4d08-becf-d05ca4e11975.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 22 56 AM" src="https://user-images.githubusercontent.com/110079631/225524935-9bd01433-e5fb-43e5-93a3-d484f9379011.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 24 24 AM" src="https://user-images.githubusercontent.com/110079631/225524957-bce7f19a-afac-423e-a24d-e1839c40cbec.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 30 57 AM" src="https://user-images.githubusercontent.com/110079631/225525098-6f5943b3-2aa1-419f-8f78-448454a140f1.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 32 39 AM" src="https://user-images.githubusercontent.com/110079631/225525138-bea9637f-2493-4765-a454-678fc46f3226.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 35 57 AM" src="https://user-images.githubusercontent.com/110079631/225525161-c170be7e-8388-480d-9480-1b9bcf1d5c44.png">


- **Fifth Challenge:-**


<img width="1512" alt="Screenshot 2023-03-14 at 11 37 46 AM" src="https://user-images.githubusercontent.com/110079631/225525243-43610f15-f230-4e21-b46c-ca36ab7505c0.png">


<img width="1512" alt="Screenshot 2023-03-14 at 11 38 07 AM" src="https://user-images.githubusercontent.com/110079631/225525267-81558290-327c-423f-b7fc-7ebd204b7f82.png">



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
