module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 2'b01;
    parameter B = 2'b10;
    reg [1:0] state,next_state;
    reg [1:0] counter,num;
    

    always @ (posedge clk)begin
        if(reset)
            state <= A;
        else
            state <= next_state;
    end

    
    always @ (*)begin
        case(state)
            A: next_state = s ? B:A;
            B: next_state = B;
        endcase
    end
    
    //对B状态内的w进行判断
    //设计计数器
    always @ (posedge clk)begin
        if(reset)
            counter <= 2'b0;
        else if(counter == 2'd2)
            counter <= 2'b0;
        else if(state == B)
            counter <= counter + 1'b1;
        else
            counter <= counter;         
    end
    
    //对进入状态B后的w值进行判断,同时还要判断是否三个周期内有两个w值为1
     always @ (posedge clk)begin
         if(reset)
             num <= 1'b0;
         else if(counter == 2'b0)begin //初值或者计数满 ，就可以进行新的统计
             num <= w ? 1'b1 : 1'b0;
         end
         else if(state == B)
             num <= w ? (num + 1'b1) : num;
         else
            num <= 1'b0; 
     end

    
    assign z = (state == B && counter == 2'd0 && num == 2'd2);     
    
    
endmodule
module top_module (
    input  clk,
    input  reset,   // Synchronous reset
    input  x,
    output z
);
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    
    reg [2:0] state,next_state;
    
    
    always @ (posedge clk)
        if(reset)
            state <= S0;
        else
            state <= next_state;

    
    always @ (*)
        case(state)
            S0: next_state = x ? S1 : S0;
			S1: next_state = x ? S4 : S1;
			S2: next_state = x ? S1 : S2;
			S3: next_state = x ? S2 : S1;
			S4: next_state = x ? S4 : S3;
        endcase
    

    always @ (*)
        if(state == S3 || state == S4)
            z = 1'b1;
        else if(state == S0 || state == S1 || state == S2)
            z = 1'b0;
        else
            z = 1'b0; 

endmodule

