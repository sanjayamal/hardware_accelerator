`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2019 11:09:46 AM
// Design Name: 
// Module Name: frontend_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module frontend_module(
input wire clk,
input wire en,
input done,

input wire [31:0] dina_input_ram,
input wire tvalid_in,
output reg tready_in=0,

output reg [31:0] dout,
output reg tvalid_out=0,
input wire tready_out 

    );
    
integer counter=0;
integer rd_counter=0;
reg [31:0] sum=0;
reg [31:0] all_sum=0;
reg [31:0] all_sum_add_2=0;
//reg [31:0] bias_sum=0;
//reg [31:0] exp_sum=0;
reg [31:0]exp_div=0;
reg[31:0] mult_add_1=0;

//input_ram variable   
reg [9:0] addra_input_ram=0;
reg [9:0] addrb_input_ram=0;
wire [31:0] doutb_input_ram;
wire wea;
//weights variable
reg ena_weights=0;
reg[15:0] addra_weights=0;
wire [31:0] douta_weights;
// add_1 variable
wire [31:0] result_add_1;
wire result_tvaild_add_1;
reg a_tvalid_add_1=0;
reg b_tvalid_add_1=0;
// mult variable
wire [31:0] result_mult;
wire result_tvaild_mult;
reg a_tvalid_mult=0;
reg b_tvalid_mult=0;
// bias variable
reg ena_bias=0;
reg [5:0]addra_bias=0;
wire [31:0] douta_bias;
// add_2 variable
wire [31:0]result_add_2;
reg a_tvalid_add_2=0;
reg b_tvalid_add_2=0;
wire result_tvalid_add_2;
//exp variable
wire result_tvalid_exp;
wire [31:0]result_exp;
reg a_tvalid_exp=0;
// add_3 variable
wire result_tvalid_add_3;
wire [31:0]result_add_3;
reg a_tvalid_add_3=0;
reg b_tvalid_add_3=0;
// div variables
reg a_tvalid_div=0;
reg b_tvalid_div=0;
wire result_tvalid_div;
wire [31:0] result_div;


assign wea=tvalid_in && tready_in;

always @(posedge clk)begin
 if(en==1)begin
    if(done==1)begin
        counter=0;
    end
    if(tvalid_in && tready_in)begin
       counter = counter+1;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(counter==0)begin
        tready_in=1;
    end
    if(counter==785)begin
        tready_in= 0;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(rd_counter==1571)begin
        tvalid_out=1;
    end
    if(rd_counter==1572)begin
        tvalid_out=0;
    end
    if(rd_counter==1575)begin
        tvalid_out=1;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(wea==1 && counter !=1 && counter !=785 )begin
       addra_input_ram = addra_input_ram+1;
    end
 end
end
always @(posedge clk)begin
 if(en==1)begin
    if(done==1)begin
     rd_counter=0;
     end
     rd_counter=rd_counter+1;
    
 end
end
always @(posedge clk)begin
 if(en==1)begin
    if(counter==785)begin
       addrb_input_ram = addrb_input_ram+1;
    end
    if(addrb_input_ram==784)begin
       addrb_input_ram = 0;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(counter==783)begin
       ena_weights =1;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(counter>=784)begin
       addra_weights = addra_weights+1;
    end
 end
end

////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(ena_weights ==1)begin
       a_tvalid_mult =1;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(ena_weights ==1)begin
       b_tvalid_mult =1;
    end
 end
end
///////////////////////

always @(posedge clk)begin
 if(en==1)begin
    if(counter==784)begin
       a_tvalid_add_1 =1;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(counter==784)begin
       b_tvalid_add_1 =1;
    end
 end
end

/////
always @(posedge clk)begin //negedge***************************
  if(en==1)begin
   if(addrb_input_ram==2)begin
     //all_sum =sum;
     all_sum =result_add_1;
   end
  end
end
//always @(posedge clk)begin
//  if(en==1)begin
//   if(addrb_input_ram==1)begin
//    all_sum_add_2= all_sum ;
//   end
//  end
//end

always @(negedge clk)begin  ///negedge***************************
 if(en==1)begin
    if(addrb_input_ram==1 && rd_counter >500)begin
      sum =0;
   // sum=result_mult;
     end
    if(counter==785 && addrb_input_ram !=1)begin
      sum = result_add_1;
    end
 end
end

always @(posedge clk)begin
  if(en==1)begin
   if(rd_counter==1570)begin
     a_tvalid_add_2 =1;
   end
   if(rd_counter== 51088)begin
   a_tvalid_add_2 =0;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
   if(rd_counter==1570)begin
     b_tvalid_add_2 =1;
   end
  if(rd_counter== 51088)begin
   b_tvalid_add_2 =0;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
   if(addrb_input_ram==1 && rd_counter >788 && rd_counter!= 1570)begin
     addra_bias =addra_bias+1;
   end
  end
end
always @(posedge clk)begin
  if(en==1)begin
   if(rd_counter==1570)begin
     ena_bias =1;
   end
   if(rd_counter== 51088)begin
    ena_bias =0;
   end
  end
end

//always @(posedge clk)begin
// if(en==1)begin
//    if(addrb_input_ram==0)begin
//       bias_sum =result_add_2;
//    end
// end
//end
always @(posedge clk)begin
  if(en==1)begin
     if(result_tvaild_add_1==1)begin
       mult_add_1=result_mult;
     end
  end
end
always @(posedge clk)begin
  if(en==1)begin
  //result_tvalid_add_2==1
   if(rd_counter==1571)begin
     a_tvalid_exp =1;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
  //result_tvalid_exp==1
   if(rd_counter==1571)begin
     a_tvalid_add_3 =1;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
  //result_tvalid_exp==1
   if(rd_counter==1572)begin 
     b_tvalid_add_3 =1;
   end
  end
end

//always @(posedge clk)begin
//  if(en==1)begin
//   if(result_tvalid_add_3==1)begin
//       exp_sum=result_add_3;
//   end
//  end
//end

always @(posedge clk)begin
  if(en==1)begin
   if(result_tvalid_add_3==1)begin
       exp_div=result_exp;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
  //result_tvalid_exp==1
   if(rd_counter==1573)begin
     a_tvalid_div =1;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
   //result_tvalid_exp==1
   if(rd_counter==1573)begin
     b_tvalid_div =1;
   end
  end
end

always @(posedge clk)begin
  if(en==1)begin
     if(result_tvalid_div==1)begin
       dout=result_div;
     end
  end
end
blk_mem_gen_1 input_ram (
      .clka(clk),    // input wire clka
      .ena(1),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addra_input_ram),  // input wire [9 : 0] addra
      .dina(dina_input_ram),    // input wire [31 : 0] dina
      .clkb(clk),    // input wire clkb
      .enb(1),      // input wire enb
      .addrb(addrb_input_ram),  // input wire [9 : 0] addrb
      .doutb(doutb_input_ram)  // output wire [31 : 0] doutb
    );
    
blk_mem_gen_2 weights (
      .clka(clk),    // input wire clka
      .ena(ena_weights),      // input wire ena
      .addra(addra_weights),  // input wire [15 : 0] addra
      .douta(douta_weights)  // output wire [31 : 0] douta
    );
    
floating_point_1 mult (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(a_tvalid_mult),            // input wire s_axis_a_tvalid
      .s_axis_a_tdata(douta_weights),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(b_tvalid_mult),            // input wire s_axis_b_tvalid
      .s_axis_b_tdata(doutb_input_ram),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(result_tvaild_mult),  // output wire m_axis_result_tvalid
      .m_axis_result_tdata(result_mult)    // output wire [31 : 0] m_axis_result_tdata
    );
   
floating_point_0 add_1 (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(a_tvalid_add_1),            // input wire s_axis_a_tvalid
      .s_axis_a_tdata(sum),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(b_tvalid_add_1),            // input wire s_axis_b_tvalid
      .s_axis_b_tdata(mult_add_1),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(result_tvaild_add_1),  // output wire m_axis_result_tvalid
      .m_axis_result_tdata(result_add_1)    // output wire [31 : 0] m_axis_result_tdata
    );
    
blk_mem_gen_3 bias (
      .clka(clk),    // input wire clka
      .ena(ena_bias),      // input wire ena  ena_bias
      .addra(addra_bias),  // input wire [5 : 0] addra
      .douta(douta_bias)  // output wire [31 : 0] douta
    );
    
floating_point_2 add_2 (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(a_tvalid_add_2),            // input wire s_axis_a_tvalid   a_tvalid_add_2
      .s_axis_a_tdata(douta_bias),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(b_tvalid_add_2),            // input wire s_axis_b_tvalid    b_tvalid_add_2
      .s_axis_b_tdata(all_sum),              // input wire [31 : 0] s_axis_b_tdata    ///all_sum_add_2
      .m_axis_result_tvalid(result_tvalid_add_2),  // output wire m_axis_result_tvalid
      .m_axis_result_tdata(result_add_2)    // output wire [31 : 0] m_axis_result_tdata
    );
    
floating_point_3 exp (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(a_tvalid_exp),            // input wire s_axis_a_tvalid
      .s_axis_a_tdata(result_add_2),              // input wire [31 : 0] s_axis_a_tdata // bais_sum
      .m_axis_result_tvalid(result_tvalid_exp),  // output wire m_axis_result_tvalid
      .m_axis_result_tdata(result_exp)    // output wire [31 : 0] m_axis_result_tdata
    );    

floating_point_4 add_3 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_add_3),            // input wire s_axis_a_tvalid  a_tvalid_add_3
  .s_axis_a_tdata(32'b00111111100000000000000000000000),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid_add_3),            // input wire s_axis_b_tvalid    b_tvalid_add_3
  .s_axis_b_tdata(result_exp),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result_tvalid_add_3),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_add_3)    // output wire [31 : 0] m_axis_result_tdata
);

floating_point_5 div (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_div),            // input wire s_axis_a_tvalid  a_tvalid_div
  .s_axis_a_tdata(exp_div),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid_div),            // input wire s_axis_b_tvalid 
  .s_axis_b_tdata(result_add_3),              // input wire [31 : 0] s_axis_b_tdata  //exp_sum  //result_add_3
  .m_axis_result_tvalid(result_tvalid_div),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_div)    // output wire [31 : 0] m_axis_result_tdata
);

endmodule
