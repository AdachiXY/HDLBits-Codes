module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=2'b01,B=2'b10;
    reg [1:0] current_state, next_state;
    
        always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else 
            current_state <= next_state;
        end    
    
    
        always @(*) begin
        	case (current_state)
            	A: next_state = x?B:A;
            	B: next_state = B;
            	default: next_state = A;
        	endcase
    	end

    
    always @(*) begin
            case(current_state)
                A: z <= x;
                B: z <= ~x;
                default: z <= 0;
            endcase
        end
    
endmodule
