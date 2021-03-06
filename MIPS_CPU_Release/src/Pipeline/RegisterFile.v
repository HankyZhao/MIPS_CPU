
module RegisterFile(reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2);
	input reset, clk;
	input RegWrite;
	input [4:0] Read_register1, Read_register2, Write_register;
	input [31:0] Write_data;
	output [31:0] Read_data1, Read_data2;
	
	reg [31:0] RF_data[31:0];
		
	assign Read_data1 = RF_data[Read_register1];
	assign Read_data2 = RF_data[Read_register2];
	
	integer i;
	always @(posedge clk or posedge reset) begin
		if (reset)
			for (i = 0; i < 32; i = i + 1)
				if (i!=29) RF_data[i] <= 32'h00000000;
				else RF_data[29] <= 32'h0000_0080;
		else if (RegWrite && (Write_register != 5'b00000))
			RF_data[Write_register] <= Write_data;
	end

endmodule		