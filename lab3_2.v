`timescale 1ns / 1ps 
module lab3_2(
			input[4:0] ticketID,
			input CLK, 
			input gate,
			input mode,
			output reg [7:0] numOfFanInH,
			output reg [7:0] numOfFanInA,
			output reg gateWar
    );
	initial begin
		numOfFanInH=0;
		numOfFanInA=0;
		gateWar=0;
	end
	integer i;
	integer j;
	integer k;
   //Modify the lines below to implement your design
	always @(posedge CLK) 
	begin
	j=0;
	k=0;
	for(i=0;i<5;i=i+1)
	begin
		if(ticketID[i]==1)
			 j=j+1;
		else
			 k=k+1;
	end
	
	if(mode)
	begin
		if(j==5 || j==4 || j==3)
		if(gate==0)
			begin
				numOfFanInH <= numOfFanInH+1;
				gateWar=0;
			end
		else 
			begin
				gateWar=1;
			end
		else if(j==2 || j==1 ||j==0)
		//Then the fan should enter from away gate
			if(gate)
			begin
				numOfFanInA <= numOfFanInA+1;
				gateWar=0;
			end
			else 
				gateWar=1;
	end
	else
	if(gate==0)
		begin
			numOfFanInH <= numOfFanInH-1;
		end
		else 
			numOfFanInA <= numOfFanInA-1;
	end
endmodule
		


