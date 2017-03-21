`timescale 1ns / 1ps
//A theoretical flip flop model is designed.
module ac(
    input a,
    input c,
    input clk,
    output reg q
    );
    
    initial begin
        q = 0;
    end

    // write your code here
	always@(posedge clk)
	 begin 
	 /*case ({a,c})
	 2'b00: q<=1'b1;
	 2'b01: q<=~q;
	 2'b10: q<=q;
	 2'b11: q<=1'b1;
	 endcase*/
	 if(a==0 && c ==0)
		q<=1'b1;
	 else if(a==0 && c==1)
		q<=~q;
	 else if(a==1 && c==0)
		q<=q;
	 else
		q<=1'b1;
	 end 


endmodule


module ic3031(
    input a0, 
    input c0, 
    input a1, 
    input c1, 
    input clk, 
    output q0, 
    output q1, 
    output y
    );
    
    // write your code here
	 ac ff1(a1,c1,clk,q1);
	 ac ff0(a0,c0,clk,q0);
	 
	 assign y=(q0&q1)|(~q0&~q1);
	 
	
	 
	 
	 

endmodule
