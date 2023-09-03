module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [7:0] Q;
    always @(posedge clk) begin
        if (~enable)
            Q <= Q;
        else begin
            Q <= {Q[6:0],S};
        end
    end
    
    always @(*)
        case({A,B,C})
            3'd0: Z = Q[0];
            3'd1: Z = Q[1];
            3'd2: Z = Q[2];
            3'd3: Z = Q[3];
            3'd4: Z = Q[4];
            3'd5: Z = Q[5];
            3'd6: Z = Q[6];
            3'd7: Z = Q[7];
            default:Z = Q[0];
        endcase



// Create a 8-to-1 mux that chooses one of the bits of q based on the three-bit number {A,B,C}:
// There are many other ways you could write a 8-to-1 mux
// (e.g., combinational always block -> case statement with 8 cases).
//assign Z = q[ {A, B, C} ];


endmodule