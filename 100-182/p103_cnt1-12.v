module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 

    count4 the_counter(.clk(clk),.enable(enable),.load(c_load),.d(c_d),.Q(Q));
assign c_enable = enable;
assign c_load   = reset | (Q == 4'd12 & enable == 1'b1);
assign c_d      = 4'b1;//复位或进位时置1
    
endmodule