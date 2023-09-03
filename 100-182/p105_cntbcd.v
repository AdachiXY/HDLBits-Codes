module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
	//one
    count Inst1_count
    (
        .clk(clk),
        .reset(reset),
        .ena(1'b1),
        .q(q[3:0])
    );
    //ten 
    count Inst2_count
    (
        .clk(clk),
        .reset(reset),
        .ena(q[3:0] == 4'd9),
        .q(q[7:4])
    );
    //hundred
    count Inst3_count
    (
        .clk(clk),
        .reset(reset),
        .ena(q[7:4] == 4'd9 && q[3:0] == 4'd9),
        .q(q[11:8])
    );
    //thousand
    count Inst4_count
    (
        .clk(clk),
        .reset(reset),
        .ena(q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9),
        .q(q[15:12])
    );
    //用来表示进位
    assign ena = {q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9, q[7:4] == 4'd9 && q[3:0] == 4'd9, q[3:0] == 4'd9};

endmodule

module count
(
    input clk,
    input reset,
    input ena,
    output reg[3:0] q
);

    always @ (posedge clk)
        begin
            if(reset)
                q <= 4'b0;
            else if (ena)
                begin
                    if(q == 4'd9) 
                        q <= 4'd0;
                    else
                        q <= q + 1'b1;
                end
        end

endmodule

/*

module top_module(
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);

    reg [3:0] ones;
    reg [3:0] tens;
    reg [3:0] hundreds;
    reg [3:0] thousands;

//个位计数器

always @ (posedge clk)begin
    if(reset)
        ones <= 4'b0;
    else if(ones == 4'd9)
        ones <= 4'b0;
    else 
        ones <= ones + 4'b1;
        
end

//十位计数器
always @ (posedge clk)begin
    if(reset)
        tens <= 4'b0;
    else if(ones == 4'd9 && tens == 4'd9  )
        tens <= 4'b0;
    else if(ones == 4'd9)  
        tens <= tens + 4'b1;
    else
        tens <= tens;
        
end

//百位计数器
always @ (posedge clk)begin
    if(reset)
        hundreds <= 4'b0;
    else if(ones == 4'd9 && tens == 4'd9  && hundreds == 4'd9  )
        hundreds <= 4'b0;
    else if(tens == 4'd9 && ones == 4'd9)
        hundreds <= hundreds + 4'b1;
    else
        hundreds <= hundreds ;
        
end

//千位计数器
always @ (posedge clk)begin
    if(reset)
        thousands <= 4'b0;
    else if(ones == 4'd9&& tens == 4'd9  && hundreds == 4'd9 && thousands == 4'd9 )
        thousands <= 4'b0;
    else if(hundreds == 4'd9 && tens == 4'd9 && ones == 4'd9)
        thousands <= thousands + 4'b1;
    else
        thousands <= thousands;
        
end
//输出q为四个四位的个位，十位，百位，千位拼接，且题目给出是从低位到高位  
assign q = {thousands,hundreds,tens,ones};
//使能信号有效
    assign ena[1] = (ones == 4'd9  ) ? 1'b1 : 1'b0;
    assign ena[2] = ((ones == 4'd9) && (tens == 4'd9 ) ) ? 1'b1 : 1'b0;
    assign ena[3] = ((ones == 4'd9) && (tens == 4'd9) &&( hundreds == 4'd9  )) ? 1'b1 : 1'b0;

    
endmodule


*/