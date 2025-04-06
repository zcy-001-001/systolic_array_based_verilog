`timescale 1ns/1ns
 `include "./rtl/adder_fp16.sv"
module accumulator(clk, reset, rd_en, wr_en, rd_addr, wr_addr, rd_data, wr_data);

    parameter ACCUM_SIZE = 1024; 

    input clk;      // 时钟
    input reset;    // 复位，高电平有效
    input rd_en;    // 读使能，高电平有效
    input wr_en;    // 写使能，高电平有效
    input [$clog2(ACCUM_SIZE)-1:0] rd_addr;     // 读地址
    input [$clog2(ACCUM_SIZE)-1:0] wr_addr;     // 写地址
    output reg [15:0] rd_data;                  // 读数据，FP16 格式
    input [15:0] wr_data;                       // 写数据，FP16 格式

    // 内部存储器，用于存储 FP16 数字
    reg [15:0] memory [0:ACCUM_SIZE-1];
    function_lib_fp16_add function_lib_ut_fp16_add();
    integer i;

    // 写操作逻辑
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // 初始化内存为零
            for (i = 0; i < ACCUM_SIZE; i = i + 1) begin
                memory[i] <= 16'd0;
            end
        end
        else if (wr_en) begin
            // 对地址 wr_addr 处的数据进行累加
            memory[wr_addr] <= function_lib_ut_fp16_add.fp16_add(memory[wr_addr], wr_data);
        end
    end

    // 读操作逻辑
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rd_data <= 16'd0;
        end
        else if (rd_en) begin
            if (wr_en && (wr_addr == rd_addr)) begin
                // 处理读写冲突，返回累加后的新数据
                rd_data <= function_lib_ut_fp16_add.fp16_add(memory[wr_addr], wr_data);
            end
            else begin
                // 从内存中读取数据
                rd_data <= memory[rd_addr];
            end
        end
        else begin
            // 当 rd_en 为低时，保持 rd_data 不变（可根据需求修改）
            rd_data <= rd_data;
        end
    end

endmodule




 

