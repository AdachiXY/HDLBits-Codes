module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    dffs inst0(
        .clk(KEY[0]),
        .in1(SW[0]),
        .in0(LEDR[2]),
        .sel(KEY[1]),
        .q(LEDR[0])
    );
    
    dffs inst1(
        .clk(KEY[0]),
        .in1(SW[1]),
        .in0(LEDR[0]),
        .sel(KEY[1]),
        .q(LEDR[1])
    );
    
    dffs inst2(
        .clk(KEY[0]),
        .in1(SW[2]),
        .in0(LEDR[1]^LEDR[2]),
        .sel(KEY[1]),
        .q(LEDR[2])
    );

endmodule

 
module dffs(
	input clk,
	input in1,
	input in0,
	input sel,
	output q
	);
	
	wire in_sel;
	assign in_sel = sel ? in1 : in0;

	always@(posedge clk) begin
		q <= in_sel;
	end
 
endmodule