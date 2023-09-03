module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [99:0] midcout;
    
    bcd_fadd ins0(.a(a[3:0]),.b(b[3:0]),.cin(cin),.cout(midcout[0]),.sum(sum[3:0]) );
    
    genvar i;
    generate
        for(i=4;i<=399;i=i+4) begin:addloop
            bcd_fadd add(.a(a[i+3:i]),.b(b[i+3:i]),.cin(midcout[i/4-1]),.cout(midcout[i/4]),.sum(sum[i+3:i]) );
        end
    endgenerate
    
    assign cout = midcout[99];
endmodule