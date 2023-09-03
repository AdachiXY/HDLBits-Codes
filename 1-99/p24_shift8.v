module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q1,q2,in3,in2,in1,in0;
    assign in0=d;
    assign in1=q1;
    assign in2=q2;
    
    my_dff8 dff1(.clk(clk),.d(d),.q(q1));
    my_dff8 dff2(.clk(clk),.d(q1),.q(q2));
    my_dff8 dff3(.clk(clk),.d(q2),.q(in3));

    always @(*)
        begin
            case(sel)
                2'b00:q=in0;
                2'b01:q=in1;
                2'b10:q=in2;
                2'b11:q=in3;
            endcase
        end
                    

endmodule