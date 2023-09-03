module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	
	count60 inst_second(
		.clk(clk),
		.reset(reset),
		.en(ena),
		.cnt_out(ss)
		);
 
	count60 inst_min(
		.clk(clk),
		.reset(reset),
		.en(ena&(ss == 8'h59)),
		.cnt_out(mm)
		);
	count12 inst_hour(
		.clk(clk),
		.reset(reset),
		.en(ena&(ss == 8'h59)&(mm == 8'h59)),
		.cnt_out(hh)
		);
    
    reg p;
    always@(posedge clk) begin
        if(reset) p <= 0;
        else if(hh == 8'h11 && ss == 8'h59&& mm == 8'h59) p <= ~p;
        else ;
	end
	assign pm = p;
 
endmodule

module count60(
	input clk,
	input reset,
	input en,
	output reg [7:0] cnt_out
	);
 
	always@(posedge clk) begin
		if(reset) cnt_out <= 0;
		else if(en) begin
			if(cnt_out == 8'h59) begin
				cnt_out <= 0;
			end
			else if(cnt_out[3:0] == 9) begin
				cnt_out[3:0] <= 0;
				cnt_out[7:4] <= cnt_out[7:4] + 1;
			end
			else begin
				cnt_out[3:0] <= cnt_out[3:0] + 1;
			end 
		end
	end
 
endmodule

module count12 (
	input clk,    // Clock
	input reset,  // Asynchronous reset active high
	input en,
	output reg [7:0] cnt_out
	);
	
	always@(posedge clk) begin
		if(reset) cnt_out <= 8'h12;
		else if(en) begin
			if(cnt_out == 8'h12) begin
				cnt_out <= 1;
			end
			else if(cnt_out[3:0] == 9) begin
				cnt_out[3:0] <= 0;
				cnt_out[7:4] <= cnt_out[7:4] + 1;
			end 
			else begin
				cnt_out[3:0] <= cnt_out[3:0] + 1;
			end
		end
	end
 
endmodule
