module scl_conb (
    HI,
    LO
);

    // Module ports
    output HI;
    output LO;

    //       Name       Output
    pullup   pullup0   (HI    );
    pulldown pulldown0 (LO    );

endmodule