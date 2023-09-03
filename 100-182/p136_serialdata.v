module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    localparam idle = 0;
    localparam start = 1;
    localparam data = 2;
    localparam stop =3;
    localparam error = 4;
    
    reg[2:0] state, next_state;
    reg[3:0] cnt;
       
    always@(posedge clk)begin
        if(reset)
            state <= idle;
        else
            state <= next_state;
    end
    
    always@(posedge clk)begin
        if(reset)
            cnt<=0;
        else
            case(next_state)
                start: cnt <= 0;
                data: cnt <= cnt+1;
                default:cnt<=cnt;
            endcase
    end
    
    always@(*)begin
        case(state)
            idle: 
                begin 
                	if (in) next_state <= idle;
                	else next_state <= start;
                end
            
            start: 
                next_state <= data;
            
            data:
                begin 
                    if (cnt != 8) next_state <= data;
                    else if (in) next_state <= stop;
                    else next_state <= error;
                end
            
            stop:
                begin 
                	if (in) next_state <= idle;
                	else next_state <= start;
                end
            
            error:
                begin 
                	if (in) next_state <= idle;
                	else next_state <= error;
                end
        endcase
    end

    always@(posedge clk)
        case(next_state)
            stop: done <= 1;
            default:done <= 0;
        endcase   
    
    //out,the serial protocol sends the least significant bit first
    always@(posedge clk)begin
        if(reset)
            out_byte <= 0;
        else
            case(next_state)
                start: out_byte <= 0;
                data: out_byte <= {in,out_byte[7:1]};
            endcase
    end
    
endmodule

