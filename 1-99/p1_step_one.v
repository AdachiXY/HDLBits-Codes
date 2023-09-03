//Build a circuit with no inputs and one output
//That output should always drive 1 (or logic high)

module top_module(in,one);

parameter WIDTH = 31;    
input in;
output one;
wire [WIDTH:0] in;
wire [WIDTH:0] one;
    
    
assign one = 32'b1;

endmodule
