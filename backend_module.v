`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2019 10:37:38 AM
// Design Name: 
// Module Name: backend_module
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


module backend_module(
input clk,
input wire tvalid_out,
input wire en,
input wire[31:0] dina_input_ram,
output reg tready_out=0,
output reg done=0 
    );
integer counter=0;
integer rd_counter=0;
integer gl_counter=0;
integer final_counter=0;
wire wea;
reg [31:0] sum=0;
reg [31:0]mult_add_1=0;
reg[31:0]all_sum=0;
reg[31:0]all_sum_add_2=0;
reg [31:0]exp_div=0;
//////////////////////
//input_ram variables
//////////////////////
reg [6:0]addra_input_ram=0;
reg [6:0]addrb_input_ram=0;
wire [31:0]doutb_input_ram;
//////////////////////
//weights varibles
//////////////////////
reg ena_weights;
reg [9:0] addra_weights=0;
wire [31:0] douta_weights;
//////////////////////
// mult variable
//////////////////////
wire [31:0] result_mult;
wire result_tvaild_mult;
//////////////////////
// add_1 variable
//////////////////////
wire [31:0] result_add_1;
wire result_tvaild_add_1;
reg a_tvalid_add_1=0;
reg b_tvalid_add_1=0;
//////////////////////
// bias variable
//////////////////////
reg ena_bias=0;
reg [5:0]addra_bias=0;
wire [31:0] douta_bias;
//////////////////////
// add_2 variable
//////////////////////
wire [31:0]result_add_2;
reg a_tvalid_add_2=0;
reg b_tvalid_add_2=0;
wire result_tvalid_add_2;
//////////////////////
//exp variable
//////////////////////
wire result_tvalid_exp;
wire [31:0]result_exp;
reg a_tvalid_exp=0;
//////////////////////
// add_3 variable
//////////////////////
wire result_tvalid_add_3;
wire [31:0]result_add_3;
reg a_tvalid_add_3=0;
reg b_tvalid_add_3=0;
//////////////////////
// div variables
//////////////////////
reg a_tvalid_div=0;
reg b_tvalid_div=0;
wire result_tvalid_div;
wire [31:0] result_div;
//////////////////////
//result_ram
//////////////////////
reg [6:0]addra_result_ram=0;
reg [6:0]addrb_result_ram=0;
wire [31:0]doutb_result_ram;
reg wea_result_ram=0;

initial begin
  #10000000;
  done =1;
end  

assign wea=tvalid_out && tready_out;
/////////////////////////////////////////////////
//// gl_counter increment 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
   if(done==1)begin
     gl_counter=0;
    end
    gl_counter=gl_counter+1;
 end
end
/////////////////////////////////////////////////
//// counter increment 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(done==1)begin
        counter=0;
    end
    if(tvalid_out && tready_out)begin
       counter = counter+1;
    end
 end
end
/////////////////////////////////////////////////
//// tvalid_out 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(counter==0)begin
        tready_out=1;
    end
    if(rd_counter==2)begin
        tready_out= 1;
     end
    if(rd_counter==3)begin
        tready_out=0;
     end
     if(counter==65)begin
         tready_out=0;
      end
 end
end
/////////////////////////////////////////////////
//// input_ram write address increment 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(wea==1 && gl_counter > 1573 )begin
       addra_input_ram = addra_input_ram+1;
    end
 end
end
/////////////////////////////////////////////////
//// rd_counter increment 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(counter!=0 && counter !=65)begin
     rd_counter=rd_counter+1;
    end
    if(rd_counter==784 || counter ==65)begin
    rd_counter=0;
    end
 end
end
/////////////////////////////////////////////////
//// input_ram read address increment 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(counter==65 )begin /////&& gl_counter!=51879
       addrb_input_ram = addrb_input_ram+1;
    end
    if(addrb_input_ram==64)begin
       addrb_input_ram = 0;
    end
 end
end
/////////////////////////////////////////////////
//// weights rom enble 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(gl_counter==51750)begin
       ena_weights =1;
    end
    if(gl_counter==52391)begin
       ena_weights =0;
    end
 end
end
/////////////////////////////////////////////////
//// weights rom read address increment 
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(gl_counter >= 51751)begin
       addra_weights = addra_weights+1;
    end
 end
end
/////////////////////////////////////////////////
//// result of add_1 equal to all sum after 64
////////////////////////////////////////////////
always @(posedge clk)begin  
  if(en==1)begin
   if(addrb_input_ram==3)begin
     all_sum =result_add_1;
   end
  end
end
/////////////////////////////////////////////////
//// result of add_1 equal to sum always
////////////////////////////////////////////////
always @(negedge clk)begin
 if(en==1)begin
    if(addrb_input_ram==2 && gl_counter > 51755 )begin
    sum =0;
     end
    if(counter==65 && addrb_input_ram !=2)begin
      sum = result_add_1;
    end
 end
end
/////////////////////////////////////////////////
//// add_2 enble
////////////////////////////////////////////////
always @(posedge clk)begin
 if(en==1)begin
    if(gl_counter== 51751)begin
       a_tvalid_add_1 =1;
    end
 end
end

always @(posedge clk)begin
 if(en==1)begin
    if(gl_counter== 51751)begin
       b_tvalid_add_1 =1;
    end
 end
end
/////////////////////////////////////////////////
//// result of multifer equal to mult_add_1 always
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
     if(result_tvaild_add_1==1)begin
       mult_add_1=result_mult;
     end
  end
end
/////////////////////////////////////////////////
//// bias rom read address increment
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(addrb_input_ram==1 && gl_counter >51820 && gl_counter!=51818)begin
     addra_bias =addra_bias+1;
   end
  end
end
/////////////////////////////////////////////////
//// bias enble
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51816)begin
     ena_bias =1;
   end
  if(gl_counter== 52457)begin
   ena_bias =0;
   end
  end
end
/////////////////////////////////////////////////
//// add_2 enble
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51817)begin
     a_tvalid_add_2 =1;
   end
   if(gl_counter== 52457)begin
   a_tvalid_add_2 =0;
   end
  end
end
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51817)begin
     b_tvalid_add_2 =1;
   end
   if(gl_counter== 52457)begin
     b_tvalid_add_2 =0;
   end
  end
end
/////////////////////////////////////////////////
//// exponent enble
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51818)begin
     a_tvalid_exp =1;
   end
   if(gl_counter==52462)begin
     a_tvalid_exp =0;
   end
 end
end
/////////////////////////////////////////////////
//// add_3 enble
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51819)begin
     a_tvalid_add_3 =1;
   end
    if(gl_counter==52462)begin
     a_tvalid_add_3 =0;
   end
  end
end
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51819)begin 
     b_tvalid_add_3 =1;
   end
   if(gl_counter==52462)begin
     b_tvalid_add_3 =0;
   end
  end
end
/////////////////////////////////////////////////
//// result of exponent equal to exp_div always
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(result_tvalid_add_3==1)begin
       exp_div=result_exp;
   end
  end
end
/////////////////////////////////////////////////
//// div enble
////////////////////////////////////////////////
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51820)begin
     a_tvalid_div =1;
   end
    if(gl_counter==52460)begin
     a_tvalid_div =0;
   end
  end
end
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51820)begin
     b_tvalid_div =1;
   end
   if(gl_counter==52460)begin
     b_tvalid_div =0;
   end
  end
end
always @(posedge clk)begin
  if(en==1)begin
   if(gl_counter==51822)begin
     wea_result_ram =1;
   end
     if(gl_counter==52460)begin
      wea_result_ram =0;
    end
  end
end
always @(posedge clk)begin
  if(en==1)begin
   if(wea_result_ram ==1 && gl_counter != 51822 && final_counter==63)begin
     addra_result_ram=addra_result_ram+1;
   end
  end
end
always @(posedge clk)begin
 if(en==1)begin
    if(gl_counter>=51823 && gl_counter<=52463)begin
     final_counter=final_counter+1;
    end
    if(final_counter==64 )begin
       final_counter=0;
    end
 end
end
always @(posedge clk)begin
  if(en==1)begin
   if (gl_counter >52463 && gl_counter <=52473)begin
     addrb_result_ram=addrb_result_ram+1;
   end
  end
end
blk_mem_gen_4 input_ram (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra_input_ram),  // input wire [6 : 0] addra
  .dina(dina_input_ram),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1),      // input wire enb
  .addrb(addrb_input_ram),  // input wire [6 : 0] addrb
  .doutb(doutb_input_ram)  // output wire [31 : 0] doutb
);
    
blk_mem_gen_5 weights (
  .clka(clk),    // input wire clka
  .ena(ena_weights),      // input wire ena
  .addra(addra_weights),  // input wire [9 : 0] addra
  .douta(douta_weights)  // output wire [31 : 0] douta
);

floating_point_6 mult (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(1),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(douta_weights),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(doutb_input_ram),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result_tvaild_mult),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_mult)    // output wire [31 : 0] m_axis_result_tdata
);

floating_point_7 add_1 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_add_1),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(sum),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid_add_1),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(mult_add_1),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result_tvaild_add_1),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_add_1)    // output wire [31 : 0] m_axis_result_tdata
);

blk_mem_gen_6 bias (
  .clka(clk),    // input wire clka
  .ena(ena_bias),      // input wire ena
  .addra(addra_bias),  // input wire [3 : 0] addra
  .douta(douta_bias)  // output wire [31 : 0] douta
);

floating_point_8 add_2 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_add_2),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(douta_bias),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid_add_2),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(all_sum),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result_tvalid_add_2),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_add_2)    // output wire [31 : 0] m_axis_result_tdata
);
floating_point_9 exp (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_exp),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(result_add_2),              // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid(result_tvalid_exp),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_exp)    // output wire [31 : 0] m_axis_result_tdata
);
floating_point_10 add_3 (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_add_3),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(32'b00111111100000000000000000000000),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid_add_3),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(result_exp),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result_tvalid_add_3),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_add_3)    // output wire [31 : 0] m_axis_result_tdata
);
floating_point_11 div (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(a_tvalid_div),            // input wire s_axis_a_tvalid
  .s_axis_a_tdata(exp_div),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(b_tvalid_div),            // input wire s_axis_b_tvalid
  .s_axis_b_tdata(result_add_3),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(result_tvalid_div),  // output wire m_axis_result_tvalid
  .m_axis_result_tdata(result_div)    // output wire [31 : 0] m_axis_result_tdata
);
blk_mem_gen_7 result_ram (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea_result_ram),      // input wire [0 : 0] wea
  .addra(addra_result_ram),  // input wire [3 : 0] addra
  .dina(result_div),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1),      // input wire enb
  .addrb(addrb_result_ram),  // input wire [3 : 0] addrb
  .doutb(doutb_result_ram)  // output wire [31 : 0] doutb
);
endmodule
