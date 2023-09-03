module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg q1,q2,q3,q4;
    always @(posedge clk)begin
        if(~resetn) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
            q4 <= 1'b0;
        end
        else begin
            q1 <= in;
            q2 <= q1;
            q3 <= q2;
            q4 <= q3;
        end  
    end 
    assign out =q4;
endmodule

/*

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0] q;
    always @(posedge clk)begin
        if(~resetn) q <= 4'b0;
        else begin
            q <= {in,q[3],q[2],q[1]};
        end
        
    end
    assign out =q[0];
endmodule

*/

/*

	reg [3:0] sr;
	
	// Create a shift register named sr. It shifts in "in".
	always @(posedge clk) begin
		if (~resetn)		// Synchronous active-low reset
			sr <= 0;
		else 
			sr <= {sr[2:0], in};
	end
	
	assign out = sr[3];		// Output the final bit (sr[3])

*/