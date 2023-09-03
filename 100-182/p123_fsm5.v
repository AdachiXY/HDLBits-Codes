module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;

    //always @(posedge clk) begin
    //        state <= next_state;
    //end   
    
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
        endcase
    end

    //assign out = (state == D);
    always @(*) begin
            case(state)
                A: out <= 0;
                B: out <= 0;
                C: out <= 0;
                D: out <= 1;
            endcase
    end

endmodule