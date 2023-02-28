module scl_schmittbuf_1 (
    X,
    A
);

    output X;
    input  A;

    // Voltage supply signals
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;

    scl_schmittbuf base (
        .X(X),
        .A(A)
    );

endmodule

module scl_schmittbuf (
    X,
    A
);

    // Module ports
    output X;
    input  A;

    // Module supplies
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;

    // Local signals
    wire buf0_out_X;

    //  Name  Output      Other arguments
    buf buf0 (buf0_out_X, A              );
    buf buf1 (X         , buf0_out_X     );

endmodule