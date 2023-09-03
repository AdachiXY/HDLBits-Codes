/*

采用一分为 2 的思路：

统计矩阵中每个元素的 8-相邻元素中 1 的个数
根据相邻元素中的 1 的个数，决定元素下一状态的值
使用组合逻辑，采用相加的方式计算相邻元素中 1 的个数
使用一个 256 长的序列来记录每个元素相邻元素中 1 的个数
最大为 8 个，所以每个元素使用 3 bit 来记录

wire [2:0] nghbr_num [255:0];


在统计时，需要处理边界绕回的的特殊情况
对于边界上的元素，根据绕回的规则确立边界
需要特殊处理的是第一/最后一行/列
在编写 Verilog 代码时，可以对这几种情况分别确立边界
引入 4 个整形变量 
idx_i_d, idx_i_u, idx_j_r, idx_j_l
在不同的情况下确立四条边界

idx_i_u = (i == 0) ? i-1+16 :i-1; //up idx
idx_i_d = (i == 15)? i+1-16 :i+1; //down idx
idx_j_l = (j == 0) ? j-1+16 :j-1; //left idx
idx_j_r = (j == 15)? j+1-16 :j+1; //right idx

使用时序逻辑，根据统计的结果，决定下一周期元素的值

输出最终结果时，将二维信号重新转换为一维信号
Verilog 不支持直接在一维/二维信号之间赋值

*/

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [15:0] q_2d [15:0]; //2-d q
    wire [2:0] nghbr_num [255:0];
    int idx_i_d,idx_i_u,idx_j_r,idx_j_l,i,j;

    //count num of neighbours
    always@(*) begin
        for(i = 0 ; i < 16 ; i = i + 1) begin
            for(j = 0 ; j < 16 ; j = j + 1) begin
                idx_i_u = (i == 0) ? i-1+16 :i-1; //up idx
                idx_i_d = (i == 15)? i+1-16 :i+1; //down idx
                idx_j_l = (j == 0) ? j-1+16 :j-1; //left idx
                idx_j_r = (j == 15)? j+1-16 :j+1; //right idx
                nghbr_num[i*16+j] = q_2d[idx_i_u][idx_j_l] + q_2d[idx_i_u][j  ] + q_2d[idx_i_u][idx_j_r]
                                +   q_2d[i      ][idx_j_l]                      + q_2d[i      ][idx_j_r]
                                +   q_2d[idx_i_d][idx_j_l] + q_2d[idx_i_d][j  ] + q_2d[idx_i_d][idx_j_r];
            end
        end
    end

    //next state transform base on num of neighbours
    always @(posedge clk) begin
        if(load) begin:init
            for(i = 0 ; i < 16 ; i = i + 1) begin
                for(j = 0 ; j < 16 ; j = j + 1) begin
                    q_2d[i][j]    <=  data[i*16+j];
                end
            end
        end
        else begin:set_val
            for(i = 0 ; i < 16 ; i = i + 1) begin
                for(j = 0 ; j < 16 ; j = j + 1) begin
                    if(nghbr_num[i*16+j] < 2)
                        q_2d[i][j]      <=  1'b0;
                    else if (nghbr_num[i*16+j] > 3)
                        q_2d[i][j]      <=  1'b0;
                    else if (nghbr_num[i*16+j] == 3)
                        q_2d[i][j]      <=  1'b1;
                    else
                        q_2d[i][j]      <=  q_2d[i][j];
                end
            end
        end
    end

    //output
    always@(*) begin
        for(i = 0 ; i < 16 ; i = i + 1) begin
            for(j = 0 ; j < 16 ; j = j + 1) begin
                q[i*16+j] = q_2d[i][j];
            end
        end
    end

endmodule