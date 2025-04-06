// Finish the design of 8x8 systolic array
// 8x8 means there are 8x8 PEs in the systolic array
// All the numbers should be in fp16 format

`timescale 1ns/1ns
//`include "/home/xinyuc/chenyu/Homework3/Name_SID/rtl/PE.sv"
`include "./rtl/PE.sv"
module systolic_array (
  input wire clk,           // Clock
  input wire reset,         // Reset the array, set it to 0
  input wire load_weight,   // Signal to load weight
  input wire valid,         // Valid signal indicating new data is available

  input wire [15:0] a_in_0,   // Input A for PE(0,0)
  input wire [15:0] a_in_1,   // Input A for PE(1,0)
  input wire [15:0] a_in_2,   // Input A for PE(2,0)
  input wire [15:0] a_in_3,   // Input A for PE(3,0)
  input wire [15:0] a_in_4,   // Input A for PE(4,0)
  input wire [15:0] a_in_5,   // Input A for PE(5,0)
  input wire [15:0] a_in_6,   // Input A for PE(6,0)
  input wire [15:0] a_in_7,   // Input A for PE(7,0)

  input wire [15:0] weight_00,  // Weight for PE(0,0)
  input wire [15:0] weight_01,  // Weight for PE(0,1)
  input wire [15:0] weight_02,  // Weight for PE(0,2)
  input wire [15:0] weight_03,  // Weight for PE(0,3)
  input wire [15:0] weight_04,  // Weight for PE(0,4)
  input wire [15:0] weight_05,  // Weight for PE(0,5)
  input wire [15:0] weight_06,  // Weight for PE(0,6)
  input wire [15:0] weight_07,  // Weight for PE(0,7)

  input wire [15:0] weight_10,  // Weight for PE(1,0)
  input wire [15:0] weight_11,  // Weight for PE(1,1)
  input wire [15:0] weight_12,  // Weight for PE(1,2)
  input wire [15:0] weight_13,  // Weight for PE(1,3)
  input wire [15:0] weight_14,  // Weight for PE(1,4)
  input wire [15:0] weight_15,  // Weight for PE(1,5)
  input wire [15:0] weight_16,  // Weight for PE(1,6)
  input wire [15:0] weight_17,  // Weight for PE(1,7)

  input wire [15:0] weight_20,  // Weight for PE(2,0)
  input wire [15:0] weight_21,  // Weight for PE(2,1)
  input wire [15:0] weight_22,  // Weight for PE(2,2)
  input wire [15:0] weight_23,  // Weight for PE(2,3)
  input wire [15:0] weight_24,  // Weight for PE(2,4)
  input wire [15:0] weight_25,  // Weight for PE(2,5)
  input wire [15:0] weight_26,  // Weight for PE(2,6)
  input wire [15:0] weight_27,  // Weight for PE(2,7)

  input wire [15:0] weight_30,  // Weight for PE(3,0)
  input wire [15:0] weight_31,  // Weight for PE(3,1)
  input wire [15:0] weight_32,  // Weight for PE(3,2)
  input wire [15:0] weight_33,  // Weight for PE(3,3)
  input wire [15:0] weight_34,  // Weight for PE(3,4)
  input wire [15:0] weight_35,  // Weight for PE(3,5)
  input wire [15:0] weight_36,  // Weight for PE(3,6)
  input wire [15:0] weight_37,  // Weight for PE(3,7)  

  input wire [15:0] weight_40,  // Weight for PE(4,0)
  input wire [15:0] weight_41,  // Weight for PE(4,1)
  input wire [15:0] weight_42,  // Weight for PE(4,2)
  input wire [15:0] weight_43,  // Weight for PE(4,3)
  input wire [15:0] weight_44,  // Weight for PE(4,4)
  input wire [15:0] weight_45,  // Weight for PE(4,5)
  input wire [15:0] weight_46,  // Weight for PE(4,6)
  input wire [15:0] weight_47,  // Weight for PE(4,7)

  input wire [15:0] weight_50,  // Weight for PE(5,0)
  input wire [15:0] weight_51,  // Weight for PE(5,1)
  input wire [15:0] weight_52,  // Weight for PE(5,2)
  input wire [15:0] weight_53,  // Weight for PE(5,3)
  input wire [15:0] weight_54,  // Weight for PE(5,4)
  input wire [15:0] weight_55,  // Weight for PE(5,5)
  input wire [15:0] weight_56,  // Weight for PE(5,6)
  input wire [15:0] weight_57,  // Weight for PE(5,7)

  input wire [15:0] weight_60,  // Weight for PE(6,0)
  input wire [15:0] weight_61,  // Weight for PE(6,1)
  input wire [15:0] weight_62,  // Weight for PE(6,2)
  input wire [15:0] weight_63,  // Weight for PE(6,3)
  input wire [15:0] weight_64,  // Weight for PE(6,4)
  input wire [15:0] weight_65,  // Weight for PE(6,5)
  input wire [15:0] weight_66,  // Weight for PE(6,6)
  input wire [15:0] weight_67,  // Weight for PE(6,7)

  input wire [15:0] weight_70,  // Weight for PE(7,0)
  input wire [15:0] weight_71,  // Weight for PE(7,1)
  input wire [15:0] weight_72,  // Weight for PE(7,2)
  input wire [15:0] weight_73,  // Weight for PE(7,3)
  input wire [15:0] weight_74,  // Weight for PE(7,4)
  input wire [15:0] weight_75,  // Weight for PE(7,5)
  input wire [15:0] weight_76,  // Weight for PE(7,6)
  input wire [15:0] weight_77,  // Weight for PE(7,7)  

  output wire [15:0] acc_out_0, // Accumulated value from PE(7,0)
  output wire [15:0] acc_out_1, // Accumulated value from PE(7,1)
  output wire [15:0] acc_out_2, // Accumulated value from PE(7,2)
  output wire [15:0] acc_out_3, // Accumulated value from PE(7,3)
  output wire [15:0] acc_out_4, // Accumulated value from PE(7,4)
  output wire [15:0] acc_out_5, // Accumulated value from PE(7,5)
  output wire [15:0] acc_out_6, // Accumulated value from PE(7,6)
  output wire [15:0] acc_out_7  // Accumulated value from PE(7,7)
);

  // Design your PE based on HW2, which performs MAC operation

  // Define the internal signals for connections between PEs
wire [15:0] row0_east0, row0_east1, row0_east2, row0_east3, row0_east4, row0_east5, row0_east6, row0_east7;
wire [15:0] row1_east0, row1_east1, row1_east2, row1_east3, row1_east4, row1_east5, row1_east6, row1_east7;
wire [15:0] row2_east0, row2_east1, row2_east2, row2_east3, row2_east4, row2_east5, row2_east6, row2_east7;
wire [15:0] row3_east0, row3_east1, row3_east2, row3_east3, row3_east4, row3_east5, row3_east6, row3_east7;
wire [15:0] row4_east0, row4_east1, row4_east2, row4_east3, row4_east4, row4_east5, row4_east6, row4_east7;
wire [15:0] row5_east0, row5_east1, row5_east2, row5_east3, row5_east4, row5_east5, row5_east6, row5_east7;
wire [15:0] row6_east0, row6_east1, row6_east2, row6_east3, row6_east4, row6_east5, row6_east6, row6_east7;
wire [15:0] row7_east0, row7_east1, row7_east2, row7_east3, row7_east4, row7_east5, row7_east6, row7_east7;

wire [15:0] row0_south0, row0_south1, row0_south2, row0_south3, row0_south4, row0_south5, row0_south6, row0_south7;
wire [15:0] row1_south0, row1_south1, row1_south2, row1_south3, row1_south4, row1_south5, row1_south6, row1_south7;
wire [15:0] row2_south0, row2_south1, row2_south2, row2_south3, row2_south4, row2_south5, row2_south6, row2_south7;
wire [15:0] row3_south0, row3_south1, row3_south2, row3_south3, row3_south4, row3_south5, row3_south6, row3_south7;
wire [15:0] row4_south0, row4_south1, row4_south2, row4_south3, row4_south4, row4_south5, row4_south6, row4_south7;
wire [15:0] row5_south0, row5_south1, row5_south2, row5_south3, row5_south4, row5_south5, row5_south6, row5_south7;
wire [15:0] row6_south0, row6_south1, row6_south2, row6_south3, row6_south4, row6_south5, row6_south6, row6_south7;
wire [15:0] row7_south0, row7_south1, row7_south2, row7_south3, row7_south4, row7_south5, row7_south6, row7_south7;


  // Connect the PEs to design your 8x8 systolic array
//row0
block row00 (a_in_0    , weight_00, 16'b0, clk,reset, row0_east0, row0_south0);
block row01 (row0_east0, weight_01, 16'b0, clk,reset, row0_east1, row0_south1);
block row02 (row0_east1, weight_02, 16'b0, clk,reset, row0_east2, row0_south2);
block row03 (row0_east2, weight_03, 16'b0, clk,reset, row0_east3, row0_south3);
block row04 (row0_east3, weight_04, 16'b0, clk,reset, row0_east4, row0_south4);
block row05 (row0_east4, weight_05, 16'b0, clk,reset, row0_east5, row0_south5);
block row06 (row0_east5, weight_06, 16'b0, clk,reset, row0_east6, row0_south6);
block row07 (row0_east6, weight_07, 16'b0, clk,reset, row0_east7, row0_south7);

//row1
block row10 (a_in_1    , weight_10, row0_south0, clk,reset, row1_east0, row1_south0);
block row11 (row1_east0, weight_11, row0_south1, clk,reset, row1_east1, row1_south1);
block row12 (row1_east1, weight_12, row0_south2, clk,reset, row1_east2, row1_south2);
block row13 (row1_east2, weight_13, row0_south3, clk,reset, row1_east3, row1_south3);
block row14 (row1_east3, weight_14, row0_south4, clk,reset, row1_east4, row1_south4);
block row15 (row1_east4, weight_15, row0_south5, clk,reset, row1_east5, row1_south5);
block row16 (row1_east5, weight_16, row0_south6, clk,reset, row1_east6, row1_south6);
block row17 (row1_east6, weight_17, row0_south7, clk,reset, row1_east7, row1_south7);

// row2
block row20 (a_in_2    , weight_20, row1_south0, clk,reset, row2_east0, row2_south0);
block row21 (row2_east0, weight_21, row1_south1, clk,reset, row2_east1, row2_south1);
block row22 (row2_east1, weight_22, row1_south2, clk,reset, row2_east2, row2_south2);
block row23 (row2_east2, weight_23, row1_south3, clk,reset, row2_east3, row2_south3);
block row24 (row2_east3, weight_24, row1_south4, clk,reset, row2_east4, row2_south4);
block row25 (row2_east4, weight_25, row1_south5, clk,reset, row2_east5, row2_south5);
block row26 (row2_east5, weight_26, row1_south6, clk,reset, row2_east6, row2_south6);
block row27 (row2_east6, weight_27, row1_south7, clk,reset, row2_east7, row2_south7);

// row3
block row30 (a_in_3    , weight_30, row2_south0, clk,reset, row3_east0, row3_south0);
block row31 (row3_east0, weight_31, row2_south1, clk,reset, row3_east1, row3_south1);
block row32 (row3_east1, weight_32, row2_south2, clk,reset, row3_east2, row3_south2);
block row33 (row3_east2, weight_33, row2_south3, clk,reset, row3_east3, row3_south3);
block row34 (row3_east3, weight_34, row2_south4, clk,reset, row3_east4, row3_south4);
block row35 (row3_east4, weight_35, row2_south5, clk,reset, row3_east5, row3_south5);
block row36 (row3_east5, weight_36, row2_south6, clk,reset, row3_east6, row3_south6);
block row37 (row3_east6, weight_37, row2_south7, clk,reset, row3_east7, row3_south7);

// row4
block row40 (a_in_4    , weight_40, row3_south0, clk,reset, row4_east0, row4_south0);
block row41 (row4_east0, weight_41, row3_south1, clk,reset, row4_east1, row4_south1);
block row42 (row4_east1, weight_42, row3_south2, clk,reset, row4_east2, row4_south2);
block row43 (row4_east2, weight_43, row3_south3, clk,reset, row4_east3, row4_south3);
block row44 (row4_east3, weight_44, row3_south4, clk,reset, row4_east4, row4_south4);
block row45 (row4_east4, weight_45, row3_south5, clk,reset, row4_east5, row4_south5);
block row46 (row4_east5, weight_46, row3_south6, clk,reset, row4_east6, row4_south6);
block row47 (row4_east6, weight_47, row3_south7, clk,reset, row4_east7, row4_south7);

// row5
block row50 (a_in_5    , weight_50, row4_south0, clk,reset, row5_east0, row5_south0);
block row51 (row5_east0, weight_51, row4_south1, clk,reset, row5_east1, row5_south1);
block row52 (row5_east1, weight_52, row4_south2, clk,reset, row5_east2, row5_south2);
block row53 (row5_east2, weight_53, row4_south3, clk,reset, row5_east3, row5_south3);
block row54 (row5_east3, weight_54, row4_south4, clk,reset, row5_east4, row5_south4);
block row55 (row5_east4, weight_55, row4_south5, clk,reset, row5_east5, row5_south5);
block row56 (row5_east5, weight_56, row4_south6, clk,reset, row5_east6, row5_south6);
block row57 (row5_east6, weight_57, row4_south7, clk,reset, row5_east7, row5_south7);

// row6
block row60 (a_in_6    , weight_60, row5_south0, clk,reset, row6_east0, row6_south0);
block row61 (row6_east0, weight_61, row5_south1, clk,reset, row6_east1, row6_south1);
block row62 (row6_east1, weight_62, row5_south2, clk,reset, row6_east2, row6_south2);
block row63 (row6_east2, weight_63, row5_south3, clk,reset, row6_east3, row6_south3);
block row64 (row6_east3, weight_64, row5_south4, clk,reset, row6_east4, row6_south4);
block row65 (row6_east4, weight_65, row5_south5, clk,reset, row6_east5, row6_south5);
block row66 (row6_east5, weight_66, row5_south6, clk,reset, row6_east6, row6_south6);
block row67 (row6_east6, weight_67, row5_south7, clk,reset, row6_east7, row6_south7);

// row7
block row70 (a_in_7    , weight_70, row6_south0, clk,reset, row7_east0, row7_south0);
block row71 (row7_east0, weight_71, row6_south1, clk,reset, row7_east1, row7_south1);
block row72 (row7_east1, weight_72, row6_south2, clk,reset, row7_east2, row7_south2);
block row73 (row7_east2, weight_73, row6_south3, clk,reset, row7_east3, row7_south3);
block row74 (row7_east3, weight_74, row6_south4, clk,reset, row7_east4, row7_south4);
block row75 (row7_east4, weight_75, row6_south5, clk,reset, row7_east5, row7_south5);
block row76 (row7_east5, weight_76, row6_south6, clk,reset, row7_east6, row7_south6);
block row77 (row7_east6, weight_77, row6_south7, clk,reset, row7_east7, row7_south7);


assign acc_out_0 =row7_south0; 
assign acc_out_1 =row7_south1;
assign acc_out_2 =row7_south2;
assign acc_out_3 =row7_south3;
assign acc_out_4 =row7_south4;
assign acc_out_5 =row7_south5;
assign acc_out_6 =row7_south6;
assign acc_out_7 =row7_south7;

endmodule
