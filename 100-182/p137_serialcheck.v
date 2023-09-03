module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter IDLE = 0, DATA = 1, CHECK = 2, STOP = 3, ERROR = 4;
    
    reg[2:0] state, next_state;
    reg[3:0] cnt;
    reg check;
    wire odd, start;
    
    parity parity_inst(
        .clk(clk),
        .reset(reset | start),
        .in(in),
        .odd(odd));    
    

    always@(posedge clk) begin
        if(reset)
            state<=IDLE;
        else
            state<=next_state;
    end
    
    
    always@(*)begin
        start = 0;
        case(state)
            IDLE:
                begin 
                    next_state <= in ? IDLE : DATA; 
                    start = 1; 
                end
            
            DATA:
                next_state <= (cnt == 8) ? CHECK : DATA;
            
            CHECK:
                next_state <= in ? STOP : ERROR;
            
            STOP:
                begin 
                    next_state <= in ? IDLE : DATA;
                    start=1;
                end
            
            ERROR:
                next_state <= in ? IDLE : ERROR;
        endcase
    end
   
    //cnt
    always@(posedge clk)begin
        if(reset)
            cnt<=0;
        else
            case(state)
                DATA: cnt <= cnt+1;
                default:cnt <= 0;
            endcase
    end
    
    //out
    always@(posedge clk)begin
        if(reset)
            out_byte <= 0;
        else
            case(next_state)
                DATA: out_byte <= {in,out_byte[7:1]};
            endcase
    end
    
    //check
    always@(posedge clk)begin
        if(reset)
            check <= 0;
        else
            check <= odd;
    end
    assign done = check&(state==STOP);
                

endmodule


/*
代码中多了 odd 和 start 变量
odd 是出题人提供的奇偶校验模块的输出
由 odd 是否为1判断校验是否正确
这里需要注意的是 start，该变量用于控制奇偶校验模块的开启
需要注意，奇偶校验模块不能一直开启
只有当开始接收数据，即出现起始标记后才开启
并且每次开启时需要复位从头进行
否则前面计算得到的 odd 输出会对下一次判断产生影响造成错误
简单来说就是每次接收新一字节数据时要重启奇偶校验模块
正是因为这个原因，所以在逻辑 always 块中
针对当前状态为 IDLE 或 STOP 时，需要将 start 置1
因为只有这两个状态的后一个状态可能是 DATA 状态
*/