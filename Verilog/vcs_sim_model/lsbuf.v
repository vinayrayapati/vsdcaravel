module scl_lsbufhv2lv_1 (
    X,
    A
);

    output X;
    input  A;

    // Voltage supply signals
    supply1 VPWR ;
    supply0 VGND ;
    supply1 LVPWR;
    supply1 VPB  ;
    supply0 VNB  ;

    scl_lsbufhv2lv base (
        .X(X),
        .A(A)
    );

endmodule

module scl_lsbufhv2lv (
    X,
    A
);

    // Module ports
    output X;
    input  A;

    // Module supplies
    supply1 VPWR ;
    supply0 VGND ;
    supply1 LVPWR;
    supply1 VPB  ;
    supply0 VNB  ;

    //  Name  Output  Other arguments
    buf buf0 (X     , A              );

endmodule