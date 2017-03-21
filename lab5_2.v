`timescale 1ns / 1ps

module VBEncoder(input CLK,
			input [7:0] INT4,input [7:0] INT3, input [7:0] INT2, input [7:0] INT1,
            input START,
            output reg READY, 
			output reg [7:0] STREAM);

//Write your code below
reg [3:0] state,next_state;


parameter T0=0,T1=1,T2=2,T3=3,T4=4,T5=5,T6=6,T7=7,T8=8,T9=9,T10=10,T11=11,T12=12,T13=13,T14=14,T15=15;
integer DONE=0;
initial begin
	READY=1;
	STREAM=8'b00000000;
	
end

always @(posedge CLK)
begin
$display("READY is %d at %d ",READY,state);
	state<=next_state;
end
always @(state or START)
begin
	case(state)
		T0:
		begin
			STREAM[7]=0;
			if(START) 
			begin
				$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
				
				next_state=T1;
				READY=0;
			end
			else
			begin
			next_state=T0;
			READY=1;
			end
		end
		T1:
		begin
			
			if(INT4>0)
				begin
					next_state=T2;
				end
			else
			begin
				
				if(INT3>0)
				begin
					next_state=T7;
				end
				else
				begin
					if(INT2>0)
					begin
						next_state=T11;
					end
					else
					begin
						if(INT1>0)
						begin
							next_state=T14;
						end
						else
							next_state=T15;
					end
				end
			end
		end
		T2:
			begin
			STREAM=INT4;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T3;
			end
		T3:
			begin
			STREAM=INT3;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T4;
			end
		T4:
			begin
			STREAM=INT2;
			
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T5;
			end
		T5:
			begin
			STREAM=INT1;
			STREAM[7]=1;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T6;
			end
		T6:
			begin
			STREAM=8'b00000000;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			READY=1;
			next_state=T0;
			end
		T7:
			begin
			STREAM=INT3;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T8;
			end
		T8:
			begin
			STREAM=INT2;
			
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T9;
			end
		T9:
			begin
			STREAM=INT1;
			STREAM[7]=1;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T10;
			end
		T10:
			begin
			STREAM=8'b00000000;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			READY=1;
			next_state=T0;
			end
		T11:
			begin
			STREAM=INT2;
			
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			 next_state=T12;
			end
		T12:
			begin
			STREAM=INT1;
			STREAM[7]=1;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T13;
			end
		T13:
		begin
			STREAM=8'b00000000;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			READY=1;
			next_state=T0;
		end
		T14:
		begin
			STREAM=INT1;
			STREAM[7]=1;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T15;
		end
		T15:
		begin
			STREAM=8'b00000000;
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			READY=1;
			next_state=T0;
		end
		default:
			begin
			$display("STREAM is %b at %d at state %d ",STREAM,$time,state);
			next_state=T0;
			end
	endcase
	end	
endmodule