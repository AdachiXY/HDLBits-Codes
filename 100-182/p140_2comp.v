module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter s0=2'b00,s1=2'b01,s2=2'b11;
    // s0: all inputs are 0 from beginning to this cycle;
    // s1: get the first "1" from beginning to this cycle;
    // s2: already get the first "1".
    reg [1:0] current_state, next_state;
    always @(*) begin
        case (current_state)
            s0: next_state = x?s1:s0;
            s1: next_state = s2;
            s2: next_state = s2;
            default: next_state = s0;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= s0;
        else 
            current_state <= next_state;
    end
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else begin
            if (next_state==s2)
                z <= ~x;
            else 
                z <= x;
        end
    end
    
endmodule


/*
对一个二进制数取补码有两种方法
一种是取反加1
另一种是将从LSB开始的第一个1之后的位全部取反

分为三种状态
s0：全为0，没有1，则补码为本身
s1：最高位为1，其他为0，即仅接收到第一个1，补码为本身
s2：接收到第一个1之后的状态，补码为第一个1之后的位取反

对于下一状态为s0和s1的，在上升沿取输入值为输出值，即本身
对于下一状态为s2的，上升沿取输入值的反为输出
*/