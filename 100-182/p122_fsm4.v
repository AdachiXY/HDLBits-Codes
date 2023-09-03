module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out);

	parameter off=0, on=1; 
    reg state, next_state;

    always @(posedge clk) begin
         if (reset) begin
            state <= off;
         end
        else
            state <= next_state;
    end   
    
    always @(*) begin
        case(state)
			off: begin
                if (~j) next_state <= off;
                if (j) next_state <= on;
            end
			on: begin
                if (~k) next_state <= on;
                if (k) next_state <= off;
            end
        endcase
    end

    //assign out = (state == B);
    always @(*) begin
            case(state)
                off: out <= 0;
                on: out <= 1;
            endcase
    end

endmodule