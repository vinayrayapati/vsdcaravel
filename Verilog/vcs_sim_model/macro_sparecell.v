module scl_macro_sparecell (
    LO
);

    // Module ports
    output LO;

    // Local signals
    wire nor2left ;
    wire invleft  ;
    wire nor2right;
    wire invright ;
    wire nd2left  ;
    wire nd2right ;
    wire tielo    ;
    wire net7     ;

    //                       Name    Output         Other arguments
    inv0d0 inv0   (.I(nor2left) , .ZN(invleft)                );
    inv0d0 inv1   (.I(nor2right), .ZN(invright)               );
    nr02d0 nor20  (.ZN(nd2left)  , .A2(nd2left), .A1(nor2left)  );
    nr02d0 nor21  (.ZN(nd2right) , .A2(nd2right), .A1(nor2right));
    nd02d0 nand20 (.ZN(tielo)    , .A2(tielo), .A1(nd2right)    );
    nd02d0 nand21 (.ZN(tielo)    , .A2(tielo), .A1(nd2left)     );
    scl_conb conb0  (.LO(tielo)   , .HI(net7)                  );
    buf buf0   (LO           , tielo                      );


endmodule