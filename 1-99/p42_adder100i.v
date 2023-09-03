module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    add1 ins0(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(cout[0]));
    genvar i;
	generate
        for(i=1;i<=99;i=i+1) begin:addloop//不需要声明int；必须有名字
            add1 ins(.a(a[i]),.b(b[i]),.cin(cout[i-1]),.sum(sum[i]),.cout(cout[i]));
        end
    endgenerate
    
endmodule


module add1 ( input a, input b, input cin,   output sum, output cout );
// Full adder module here
assign sum = a ^ b ^ cin;
assign cout = a&b | a&cin | b&cin;
    
endmodule