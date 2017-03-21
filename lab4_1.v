`timescale 1ns / 1ps


module add_checksum(
	input [1:9] acInput,
	output reg [1:12] acOutput
    );
	 
//Write your code below
reg [0:2] checksum=0;
integer i;
always@*
begin
	for(i=1;i<=9;i=i+1)
	begin
		checksum=(checksum+(acInput[i]*i))%8;
	end
	acOutput[1:9]=acInput;
	acOutput[10:12]=checksum;
	checksum=0;
end
endmodule


module detect_error(
	input [1:12] decInput,
	output reg [1:9] decOutput
    );


//Write your code below
reg [0:2] detect=0;
integer i;
always@*
begin
	for(i=1;i<=9;i=i+1)
	begin
		detect=(detect+(decInput[i]*i))%8;
	end
	/*$display("detect_error = %b, decInput[10:12] = %b",detect,decInput[10:12]);*/
	if(detect[0:2]==decInput[10:12])
	begin
		decOutput=decInput[1:9];
		/*$display("decOutput = %b",decOutput);*/
	end
	else
	begin
		decOutput=9'b000000000;
		/*$display("decOutput = %b",decOutput);*/
	end
	detect=0;
end

endmodule


module RAM(
	input [8:0] rInput, 
	input CLK,
	input Mode, //0:read, 1:write
	input [3:0] rAddress,
	output reg [8:0] rOutput);

//Write your code below
reg [8:0] ram [0:15];
integer i,j;
initial begin
for(i=0;i<16;i=i+1)
begin
	for(j=0;j<9;j=j+1)
	begin
		ram[i][j]=1'b1;
	end
end

rOutput=ram[0];
end
always@(posedge CLK)
begin
if(Mode)
begin
	ram[rAddress]=rInput;
end
else
begin
	rOutput=ram[rAddress];
end
end
endmodule	

module ISBN_RAM(
	input [11:0] isbnInput,
	input CLK,
	input Mode, //0:read, 1:write
	input [3:0] isbnAddress,
	output  [11:0] isbnOutput);

wire [1:9] detect_errorToRam;  
wire [1:9] ramToadd_checksum; 

//DO NOT EDIT THIS MODULE
detect_error DC (isbnInput,detect_errorToRam);
RAM RM(detect_errorToRam,CLK,Mode,isbnAddress,ramToadd_checksum);
add_checksum EN (ramToadd_checksum,isbnOutput);
//DO NOT EDIT THIS MODULE
endmodule