module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z
); 
    parameter S0 = 3'b001;
    parameter S1 = 3'b010;
    parameter S2 = 3'b100;
    
    reg [2:0] state;
    reg [2:0] next_state;  

    always @(posedge clk or negedge aresetn)
        if(!aresetn)
            state <= S0;
        else
            state <= next_state;

    always @ (*)
        case(state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S2;
            S2: next_state = x ? S1 : S0;
            default:next_state = S0;
        endcase

    always @ (*)begin
      case(state)
          S2: begin
              if (x) z = 1;
          		else z = 0;
          end
          default: z = 0;
      endcase
    end
      //assign  z = (state == S2) ? x : 1'b0; //米利状态机，输出与输入x有关

endmodule

