module scl_diode_2 (
    DIODE
);

    input DIODE;

    // Voltage supply signals
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;

    scl_diode base (
        .DIODE(DIODE)
    );

endmodule

module scl_diode (
    DIODE
);

    // Module ports
    input DIODE;

    // Module supplies
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;
     // No contents.
endmodule