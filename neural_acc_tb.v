`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2019 09:48:30 AM
// Design Name: 
// Module Name: neural_acc_tb
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


module neural_acc_tb(

    );
reg clk;
reg en=1;
reg tvalid_in=1;
reg [9:0] addra_input_buf=0;
wire[31:0] douta_input_buf;  
wire tready_in;
wire done;
integer counter=0;

initial begin 
  clk =0;
  repeat(1000000000)
  begin
  clk=~clk;
  #10;
  end
end

//initial begin
//    #0;
//    en =1;
//    #100;
//    en=0;
//    #100;
//    en=1;

//end 


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
        tvalid_in=1;
    end
 end
end



always @(posedge clk)begin
 if(en==1)begin
    if(tvalid_in && tready_in)begin
       addra_input_buf = addra_input_buf+1;
    end
 end
end



blk_mem_gen_0 input_buf (
      .clka(clk),    // input wire clka
      .ena(1),      // input wire ena
      .addra(addra_input_buf),  // input wire [9 : 0] addra
      .douta(douta_input_buf)  // output wire [31 : 0] douta
);

neural_acc_v1_0 neural_acc_v1_0(
    .clk(clk),
    .s00_axis_tdata(douta_input_buf),
    .s00_axis_tready(tready_in),
    .s00_axis_tvalid(tvalid_in),
    .done(done),
    .en(en)
);
endmodule
