module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
wire cin1;
    wire [31:0] xout;
    assign xout = b^({32{sub}});//注意这里要拼接
    add16 ad1(.a(a[15:0]), .b(xout[15:0]), .cin(sub), .sum(sum[15:0]), .cout(cin1) );
    add16 ad2(.a(a[31:16]), .b(xout[31:16]), .cin(cin1), .sum(sum[31:16]), .cout() );
   
endmodule