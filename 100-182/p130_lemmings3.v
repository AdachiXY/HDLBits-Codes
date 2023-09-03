module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,

    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter WL=0,WR=1,FL=2,FR=3,DL=4,DR=5;
    reg [2:0]state,next;
    //state transtition logic
    always @(*)
        begin
            case(state)
                WL: next = ground? (dig? DL : (bump_left? WR:WL) ):FL;
                WR: next = ground? (dig? DR : (bump_right?WL:WR) ):FR;
                FL: next = ground? WL : FL;
                FR: next = ground? WR : FR;
                DL: next = ground? DL : FL;
                DR: next = ground? DR : FR;
            endcase
        end
    always @(posedge clk or posedge areset)
        if(areset) state <= WL;
    	else state <= next;
    always @(*)
        case(state) 
            WL: {walk_left,walk_right,aaah,digging} = 4'b1000;
            WR: {walk_left,walk_right,aaah,digging} = 4'b0100;
            FL: {walk_left,walk_right,aaah,digging} = 4'b0010;
            FR: {walk_left,walk_right,aaah,digging} = 4'b0010;
            DL: {walk_left,walk_right,aaah,digging} = 4'b0001;
            DR: {walk_left,walk_right,aaah,digging} = 4'b0001;    
        endcase
endmodule


/*

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT=0, RIGHT=1,fall_left=2,fall_right=3,digholeL=4,digholeR=5;
    reg [2:0] state, next_state;
    
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
                if (~ground) next_state <= fall_left;
                else if (dig) next_state <= digholeL;
                else if (bump_left) next_state <= RIGHT;
                else next_state <= LEFT;
            end
			RIGHT: begin
                if (~ground) next_state <= fall_right;
                else if (dig) next_state <= digholeR;
                else if (bump_right) next_state <= LEFT;
                else next_state <= RIGHT;
            end
            fall_left: begin
                if (~ground) next_state <= fall_left;
                else next_state <= LEFT;
            end
            fall_right: begin
                if (~ground) next_state <= fall_right;
                else next_state <= RIGHT;
            end
            digholeL:begin
                if (~ground) next_state <= fall_left;
                else next_state <= digholeL;
            end 
            digholeL:begin
                if (~ground) next_state <= fall_right;
                else next_state <= digholeR;
            end
        endcase
    end
    
        always @(*) begin
            case(state)
                LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
                fall_left: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                fall_right: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                digholeL: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                digholeR: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                default: begin 
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
    end
endmodule

*/