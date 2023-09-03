module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    assign heater = (mode&too_cold) ? 1:0 ;
    assign aircon = (~mode&too_hot) ? 1:0 ;
    assign fan = (fan_on|heater|aircon) ? 1 : 0 ;
endmodule