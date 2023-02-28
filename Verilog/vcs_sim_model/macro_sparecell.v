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
    nr02d0 nor20  (.B(nd2left)  , .A(nd2left), .Y(nor2left)  );
    nr02d0 nor21  (.B(nd2right) , .A(nd2right), .Y(nor2right));
    nd02d0 nand20 (.B(tielo)    , .A(tielo), .Y(nd2right)    );
    nd02d0 nand21 (.B(tielo)    , .A(tielo), .Y(nd2left)     );
    scl_conb conb0  (.LO(tielo)   , .HI(net7)                  );
    buf buf0   (LO           , tielo                      );

endmodule