module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);

wire [3:0] q1, q2, q3;
    always@ (*)
        if(reset) begin
            c_enable <= 3'b0;
            OneHertz <= 1'b0;
        end
    	else begin
            c_enable[0] <= 1'b1;
            c_enable[1] <= (q1 == 4'd9) ? 1'b1 : 1'b0;
            c_enable[2] <= ((q1 == 4'd9) && (q2 == 4'd9)) ? 1'b1 : 1'b0;
            OneHertz <= ((q1 == 4'd9) && (q2 == 4'd9) && (q3 == 4'd9)) ? 1'b1 : 1'b0;
        end

    bcdcount counter0 (
        .clk(clk), 
        .reset(reset), 
        .enable(1'b1), 
        .Q(q1)
    );
   bcdcount counter1 (
        .clk(clk), 
        .reset(reset), 
       .enable( c_enable[1]), 
       .Q(q2)
    );
    bcdcount counter2 (
        .clk(clk), 
        .reset(reset), 
        .enable(c_enable[2]), 
        .Q(q3)
    );



endmodule


