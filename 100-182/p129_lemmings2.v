module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT=0, RIGHT=1,fall_left=2,fall_right=3;
    reg [1:0] state, next_state;
    
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
                if (~bump_left&ground) next_state <= LEFT;
                else if (bump_left&ground) next_state <= RIGHT;
                else if (~bump_left&~ground) next_state <= fall_left;
                else if (bump_left&~ground) next_state <= fall_left;
                else next_state <= LEFT;
            end
			RIGHT: begin
                if (bump_right&ground) next_state <= LEFT;
                else if (~bump_right&ground) next_state <= RIGHT;
                else if (~bump_right&~ground) next_state <= fall_right;
                else if (bump_right&~ground) next_state <= fall_right;
                else next_state <= RIGHT;
            end
            fall_left: begin
                if (~ground) next_state <= fall_left;
                else if (ground) next_state <= LEFT;
                else next_state <= fall_left;
            end
            fall_right: begin
                if (~ground) next_state <= fall_right;
                else if (ground) next_state <= RIGHT;
                else next_state <= fall_right;
            end
        endcase
    end
    
        always @(*) begin
            case(state)
                LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
                RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end
                fall_left: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                fall_right: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                default: begin 
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
            endcase
    end
endmodule