module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter  b1=0,b2=1,b3=2,d=3;
    reg [1:0] state,next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= b1;
         end
         else
            state <= next_state;
    end

    always@(*) begin
        case(state)
            b1:begin
                if(in[3]) next_state <= b2;
                else next_state <= b1;
            end
            b2:begin
				next_state <= b3;
            end
            b3:begin
				next_state <= d;
            end
            d:begin
                if(in[3]) next_state <= b2;
                else next_state <= b1;
            end
        endcase
    end
    
    always@(*) begin
        case(state)
            d: done <= 1;
        default:done <= 0;
        endcase
    end
endmodule
