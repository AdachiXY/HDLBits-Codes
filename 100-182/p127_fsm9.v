module top_module (
     input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [1:0] state,next_state;
    parameter s0=0,s1=1,s2=2,s3=3;


    always @(posedge clk)
        begin
            if(reset)
                state <= s0;
            else
                state <= next_state;
        end


    always @(*)
        begin
            case(state)
                s0: begin
                    if(s == 3'b000)
                        next_state = s0;
                    else if(s == 3'b001)
                        next_state = s1;
                end
                s1:begin
                    if(s == 3'b001)
                        next_state = s1;
                    else if(s == 3'b011)
                        next_state = s2;
                    else if(s == 3'b000)
                        next_state = s0;
                end
                s2:begin
                    if(s == 3'b011)
                        next_state = s2;
                    else if(s == 3'b111)
                        next_state = s3;
                    else if(s == 3'b001)
                        next_state = s1;
                end
                s3:begin
                    if(s == 3'b111)
                        next_state = s3;
                    else if(s == 3'b011)
                        next_state = s2;
                end
                default: next_state = s0;
            endcase        
        end


    always @(posedge clk)
        begin
            if(reset)
				begin
            {fr1,fr2,fr3} = 3'b111;
            dfr = 1'b1;
				end 
            else 
				begin
                    case(next_state) 
                        s0:begin
                        {fr1,fr2,fr3} = 3'b111;
                         dfr = 1'b1;
                        end
                        s1:begin
                            {fr1,fr2,fr3} = 3'b110;
                            if(state == s0 & next_state ==  s1)
                                dfr = 1'b0;
                            else if(state == s1 && next_state == s1)
                                dfr = dfr;
                            else
                                dfr = 1'b1;
                        end
                        s2:begin
                            {fr1,fr2,fr3} = 3'b100;
                            if(state == s1 & next_state ==  s2)
                                dfr = 1'b0;
                            else if(state == s2 && next_state == s2)
                                dfr = dfr;
                            else
                                dfr = 1'b1;
                        end
                        s3:begin
                            {fr1,fr2,fr3} = 3'b000;
                            if(state == s2 & next_state ==  s3)
                                dfr = 1'b0;
                            else if(state == s3 && next_state == s3)
                                dfr = dfr;
                            else
                                dfr = 1'b1;
                        end
                endcase
        end
		end 
endmodule

/*
第三个always里面的case语句为什么是判断下一个状态而不是直接判断这个状态的state值?

这个操作是时序的，如果判断的是case（state）就变成下个CLK的状态了
如果是组合逻辑的话，case语句判断的就是state而不是next_state
根据下一个状态是什么来决定输出

dfr输出用组合逻辑为什么不行?

因为dfr比较的是现在时刻和上一个时刻的
而state和next_state是这个时刻和下个时刻
所以这个输出需要延迟一个cycle