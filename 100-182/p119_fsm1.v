module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out); 

    parameter A=0, B=1; 
    reg state, next_state;

     always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
         if (areset) begin
            state <= B;
         end
        else
            state <= next_state;
    end   
    
    always @(*) begin    // This is a combinational always block
        // State transition logic
        case(state)
			A: next_state <= in ? A : B;
			B: next_state <= in ? B : A;
        endcase
    end

    // Output logic
    //assign out = (state == B);
    always @(*/*posedge clk, posedge areset*/) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        //if (areset)
            //out <= 0;
        //else begin
            case(state)
                A: out <= 0;
                B: out <= 1;
            endcase
        //end
    end 

endmodule