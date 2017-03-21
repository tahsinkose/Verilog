`timescale 1ns / 1ps

//Simple refectory automata logic. At most 8 student is allowed.
module lab4_2(
			input[2:0] studentID,
			input[2:0] credit,
			input [1:0] mode,
			input  incTime,
			input CLK, 
			output reg [4:0]  stime,
			output reg  [2:0] idOutput,
			output reg endOfListWar,
			output reg  [3:0] studentCount,
			output reg  [6:0] totalCredits
			
	);
	
//Write your code below
reg [2:0]ID_list[1:7];
reg [6:0]studentCredit[1:7];
reg [6:0]limit[1:7];
reg [1:7]suspendList;
reg [2:0]poor_ID[1:7];


integer i,j=0;
integer flag=0;
integer cnt=0;
integer flag2=0;
integer warning=1;
integer x=0;
integer count_poors=0;
integer flagCount=0;
integer alreadyChecked=0;
integer flag3=0;



initial begin
	for(i=1;i<8;i=i+1)
	begin
		limit[i]=0;
		suspendList[i]=0;
		ID_list[i]=0;
		poor_ID[i]=0;
	end
	stime=0;
	endOfListWar=0;
	idOutput=0;
	studentCount = 0;
	totalCredits=0;
end

always @(posedge CLK)
begin 

if(incTime==0)
begin
	flag=0;
	case(mode)
		2'b00:
		begin
		flagCount=0;
		x=0;
		endOfListWar=0;
		warning=1;
			for(i=1;i<8;i=i+1)
			begin
				if(studentID==ID_list[i])
				begin
					flag=1;
				end
			end
			if(flag==0)
			begin
				ID_list[studentCount+1]=studentID;
				studentCredit[studentID]=0;
				studentCount=studentCount+1;
			end
		end
		2'b01:
		begin
		flagCount=0;
		x=0;
		endOfListWar=0;
		warning=1;
			if(studentCredit[studentID]>=credit)
			begin
				studentCredit[studentID]=studentCredit[studentID]-credit;
				totalCredits=totalCredits-credit;
				limit[studentID]=limit[studentID]+credit;
				if(limit[studentID] > 4)//Orla yazilabilir.
				begin
					suspendList[studentID]=1;
				end	
			end
		end
		2'b10:
		begin
		flagCount=0;
		x=0;
		endOfListWar=0;
		warning=1;
			for(i=1;i < 8;i=i+1)
			begin
				if(ID_list[i]!= 0 && suspendList[ID_list[i]]==0)
				begin
					cnt=cnt+1;//Count the non-suspended students
					studentCredit[ID_list[i]]=studentCredit[ID_list[i]]+credit;//Increase each student's account.
				end
			end
			totalCredits=totalCredits + (credit*cnt);//Increase total credits.
			
			for(i=1;i< 8;i=i+1)
			begin
				suspendList[i]=0;
			end
			cnt=0;
		end
		2'b11:
		begin
			if(warning==0)
			begin
				endOfListWar=1;
				idOutput=0;
			end
			if(flagCount==0)
			begin
				for(i=1;i < 8 ;i=i+1)
				begin
					if(ID_list[i]!=0 && studentCredit[ID_list[i]]<credit)
					begin
						count_poors=count_poors+1;
						flagCount=1;
					end //Here we counted the poor credit student number only once.
				end
			end
			for(i = 1;i < 8;i=i+1)
			begin
				
				if(x<count_poors && flag2==0)
				begin
					for(j=1;j<8;j=j+1)
					begin
						if(flag3==0 && ID_list[i]!= 0 && poor_ID[j]!=0 && studentCredit[ID_list[i]] < credit && ID_list[i]==poor_ID[j])//In here I checked every calculated poors and valid ID.
						begin
							alreadyChecked=1;
							flag3=1;
						end
					end
					
					if(alreadyChecked==0 && studentCredit[ID_list[i]] < credit)//Meaningly ID was never faced before
					begin
						poor_ID[i]=ID_list[i];
						idOutput=poor_ID[i];
						flag2=1;
						x=x+1;
					end
					alreadyChecked=0;
					flag3=0;
				end
				
			end
			
			if(x==count_poors)
			begin
				warning=0;
			end
			flag2=0;
			alreadyChecked=0;
			flag3=0;
		end
	endcase	
end
else
begin
	stime=stime+1;
	if(stime>23)
	begin
		stime=stime-24;
	end
	for(i=1;i<8;i=i+1)
	begin
		limit[i]=0;
	end
end
		
			

end
endmodule
