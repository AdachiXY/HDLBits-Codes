//算数右移和逻辑右移的区别
//逻辑右移不考虑符号位，空缺的位置补领操作即可
//算数右移动需要考虑符号位，右移一位，如果符号位为1，则在符号位补1
//如果符号位为0，则在符号位补0
//即算数右移后，空缺的位置补符号位的数字即可


module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
always @(posedge clk) begin
		if (load)
			q <= data;
    	else if (~ena)
        q <=q;
    	else begin
            case(amount)
                2'b00: q <= {q[62:0],1'b0}; //shift left by 1 bit.
                2'b01: q <= {q[55:0],{8{1'b0}}}; //shift left by 8 bits.
                2'b10: q <= {q[63],q[63:1]}; //shift right by 1 bit.
                2'b11: q <= {{8{q[63]}},q[63:8]}; //shift right by 8 bits.
                default: q <= q;
            endcase
        end     
	end
endmodule