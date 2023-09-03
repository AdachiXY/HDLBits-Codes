module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
wire cin1,sel;
wire [15:0] in0, in1;
    
    add16 adlo(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(sel) );
    add16 adh1(.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(in0), .cout() );
    add16 adh2(.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(in1), .cout() );

//assign sum[31:16] = sel ? in1 : in0;    
    always @(*)
        begin
            case(sel)
                1'b0:sum[31:16]=in0;
                1'b1:sum[31:16]=in1;
            endcase
                 
        end
    
    
endmodule