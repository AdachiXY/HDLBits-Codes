module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    always @(*) begin
        out = 0;
        for(int i=0;i<=254;i=i+1)//此处用integer i先声明就会报错
        if (in[i]==1'b1) 
            out = out+1;
        else
            out = out+0;
    end
endmodule