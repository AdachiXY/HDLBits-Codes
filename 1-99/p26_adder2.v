module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
wire cin1;
    add16 ad1(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(cin1) );
    add16 ad2(.a(a[31:16]), .b(b[31:16]), .cin(cin1), .sum(sum[31:16]), .cout() );
    
    
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
// Full adder module here
assign sum = a ^ b ^ cin;
assign cout = a&b | a&cin | b&cin;
    
endmodule