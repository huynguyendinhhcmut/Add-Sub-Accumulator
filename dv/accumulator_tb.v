module accumulator_tb;

	`ifdef Width
        	parameter Width = `Width;
    	`else
        	parameter Width = 32;
    	`endif

	reg clk, rst;
	reg [Width-1:0] A;
	reg cin;

	wire overflow, carry;
	wire [Width-1:0] sum;
	wire [Width-1:0] pre_sum;

	integer i;

accumulator #(.Width(Width)) dut (.*);

initial begin
	$dumpfile ("accumulator_wave.vcd");
	$dumpvars (0, accumulator_tb);
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin
	rst = 0;
	cin = 0;

	#1;
	rst = 1;	
	A = 1;

	@(posedge clk)
	$display (" ");
	$display ("Test case 1: cin = %d,  Width = %d", cin, Width);

	for (i = 0; i < (1 << Width); i = i + 1) begin
		@(posedge clk)
		if ((overflow == 1) & (carry == 1)) begin
			$display ("A = %d, S = %d, overflow = %d, carry: %d. DETECT BOTH OVERFLOW AND CARRY", A, sum, overflow, carry);	
		end else if (overflow == 1) begin
			$display ("A = %d, S = %d, overflow = %d, carry: %d. DETECT OVERFLOW", A, sum, overflow, carry);
		end else if (carry == 1) begin
			$display ("A = %d, S = %d, overflow = %d, carry: %d. DETECT CARRY", A, sum, overflow, carry);
		end else
			$display ("A = %d, S = %d, overflow = %d, carry: %d", A, sum, overflow, carry);
	end

	#1;
	rst = 0;

	#1;
	rst = 1;
	cin = 1;	
	A = 1;

	@(posedge clk)
	$display (" ");
	$display ("Test case 1: cin = %d,  Width = %d", cin, Width);
	
	for (i = 0; i < (1 << Width); i = i + 1) begin
		@(posedge clk)
		if ((overflow == 1) & (carry == 1)) begin
			$display ("A = %d, S = %d, overflow = %d, carry: %d. DETECT BOTH OVERFLOW AND CARRY", A, sum, overflow, carry);	
		end else if (overflow == 1) begin
			$display ("A = %d, S = %d, overflow = %d, carry: %d. DETECT OVERFLOW", A, sum, overflow, carry);
		end else if (carry == 1) begin
			$display ("A = %d, S = %d, overflow = %d, carry: %d. DETECT CARRY", A, sum, overflow, carry);
		end else
			$display ("A = %d, S = %d, overflow = %d, carry: %d", A, sum, overflow, carry);
	end
		
	#50;
	$finish;
end

endmodule
