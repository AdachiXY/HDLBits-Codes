module top_module(
    input clk,
    input in,
    input reset,
    output out);
    
    parameter A=4'b0001, B=4'b0010, C=4'b0100, D=4'b1000;
    reg [3:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
          state <= next_state;
        end
    end   
    
    always @(*) begin
        case(state)
			A: begin
                if (~in) next_state <= A;
                if (in) next_state <= B;
            end
			B: begin
                if (~in) next_state <= C;
                if (in) next_state <= B;
            end
            C: begin
                if (~in) next_state <= A;
                if (in) next_state <= D;
            end
            D: begin
                if (~in) next_state <= C;
                if (in) next_state <= B;
            end
            default: next_state <= A;
        endcase
    end

    //assign out = (state == D);
    always @(*) begin
            case(state)
                A: out <= 0;
                B: out <= 0;
                C: out <= 0;
                D: out <= 1;
                default: out <= 0;
            endcase
    end

endmodule
