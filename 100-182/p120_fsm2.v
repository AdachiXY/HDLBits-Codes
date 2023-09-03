// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

	parameter A=0, B=1; 
    reg state, next_state;

     always @(posedge clk) begin
         if (reset) begin
            state <= B;
         end
        else
            state <= next_state;
    end   
    
    always @(*) begin
        case(state)
			A: next_state <= in ? A : B;
			B: next_state <= in ? B : A;
        endcase
    end

    //assign out = (state == B);
    always @(*) begin
            case(state)
                A: out <= 0;
                B: out <= 1;
            endcase
    end

endmodule