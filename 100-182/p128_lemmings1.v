module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
         if (areset) begin
            state <= LEFT;
         end
         else
            state <= next_state;
    end
    
	always @(*) begin
        // State transition logic
        case(state)
			LEFT: begin
                if (~bump_left) next_state <= LEFT;
                else next_state <= RIGHT;
            end
			RIGHT: begin
                if (bump_right) next_state <= LEFT;
                else next_state <= RIGHT;
            end
        endcase
    end

    
    // Output logic
    // assign walk_left = (state == LEFT);
    // assign walk_right = (state == RIGHT);
        always @(*) begin
            case(state)
                LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                end
                RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                end
                default: begin 
                    walk_left <= 1;
                    walk_right <= 0;
                end
            endcase
    end
    

endmodule
