module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    always @(posedge clk)
        if(load)
            q <= data;
    	else begin
            q[0] <= 1'b0^q[1];
            q[511] <= 1'b0^q[510];
            for (int i=1;i<=510;i++) begin
                q[i] <= q[i-1]^q[i+1];
            end
    end
endmodule

/*

	always @(posedge clk) begin
		if (load)
			q <= data;	// Load the DFFs with a value.
		else begin
			// At each clock, the DFF storing each bit position becomes the XOR of its left neighbour
			// and its right neighbour. Since the operation is the same for every
			// bit position, it can be written as a single operation on vectors.
			// The shifts are accomplished using part select and concatenation operators.
			
			//     left           right
			//  neighbour       neighbour
			q <= q[511:1] ^ {q[510:0], 1'b0} ;
		end
	end

*/

/*

always @(posedge clk) begin
if (load)
    q <= data;
else
    q <= (q<<1)^(q>>1); //for太麻烦，参考答案也太麻烦了。
end

*/