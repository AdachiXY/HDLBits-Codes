module top_module(
    input  clk,
    input  reset,    // Synchronous reset
    input  in,
    output  reg disc,
    output  reg flag,
    output  reg err
);

    parameter IDLE  = 5'b00001;
    parameter DATA  = 5'b00010;
    parameter DISC  = 5'b00100;
    parameter FLAG  = 5'b01000;
    parameter ERROR = 5'b10000;

    reg [4:0] current_state;
    reg [4:0] next_state;
    reg [2:0] counter;
    
    
    always @(posedge clk) begin
        if(reset)begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    
    always @(*) begin
        case(current_state)
            IDLE:begin
                next_state = in ? DATA : IDLE;
            end
            DATA:begin
                case(counter)
                    3'd5:   next_state = in ? DATA : DISC;
                    3'd6:   next_state = in ? ERROR : FLAG;
                    default:next_state = in ? DATA : IDLE;
                endcase
            end
            DISC:begin
                next_state = in ? DATA : IDLE;
            end
            FLAG:begin
                next_state = in ? DATA : IDLE;
            end
            ERROR:begin
                next_state = in ? ERROR : IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if(reset)begin
            disc <= 1'd0;
            flag <= 1'd0;
            err  <= 1'd0;
            counter <= 3'd0;
        end
        else begin
            case(next_state)
                DATA:begin
                    disc <= 1'd0;
                    flag <= 1'd0;
                    err  <= 1'd0;
                    counter <= counter + 1'd1;
                end
                DISC:begin
                    disc <= 1'd1;
                    flag <= 1'd0;
                    err  <= 1'd0;
                    counter <= 3'd0;
                end
                FLAG:begin
                    disc <= 1'd0;
                    flag <= 1'd1;
                    err  <= 1'd0;
                    counter <= 3'd0;
                end
                ERROR:begin
                    disc <= 1'd0;
                    flag <= 1'd0;
                    err  <= 1'd1;
                    counter <= 3'd0;
                end
                default:begin
                    disc <= 1'd0;
                    flag <= 1'd0;
                    err  <= 1'd0;
                    counter <= 3'd0;
                end
            endcase
        end
    end

endmodule

