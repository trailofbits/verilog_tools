module circuit(
input [1454:0] current,
input [1454:0] next,

output [0:0] result,
output [0:0] dummy
);
wire [31:0] Advice_1 = current[31: 0];
wire [2:0] Advice_2 = current[34: 32];
wire [2:0] Advice_3 = current[37: 35];
wire [2:0] Advice_4 = current[40: 38];
wire [31:0] Advice_5 = current[72: 41];
wire In_error_flag = current[73: 73];
wire In_register_AF = current[338: 338];
wire In_register_CF = current[339: 339];
wire [31:0] In_register_CSBASE = current[371: 340];
wire [7:0] In_register_DF = current[379: 372];
wire [31:0] In_register_DSBASE = current[411: 380];
wire [31:0] In_register_EAX = current[443: 412];
wire [31:0] In_register_EBP = current[475: 444];
wire [31:0] In_register_EBX = current[507: 476];
wire [31:0] In_register_ECX = current[539: 508];
wire [31:0] In_register_EDI = current[571: 540];
wire [31:0] In_register_EDX = current[603: 572];
wire [31:0] In_register_EIP = current[635: 604];
wire [31:0] In_register_ESBASE = current[667: 636];
wire [31:0] In_register_ESI = current[699: 668];
wire [31:0] In_register_ESP = current[731: 700];
wire [31:0] In_register_FSBASE = current[763: 732];
wire [31:0] In_register_GSBASE = current[795: 764];
wire In_register_OF = current[796: 796];
wire In_register_PF = current[797: 797];
wire In_register_SF = current[798: 798];
wire [31:0] In_register_SSBASE = current[830: 799];
wire In_register_ZF = current[831: 831];
wire [63:0] In_timestamp = current[895: 832];
wire Out_error_flag = next[73: 73];
wire Out_register_AF = next[338: 338];
wire Out_register_CF = next[339: 339];
wire [31:0] Out_register_CSBASE = next[371: 340];
wire [7:0] Out_register_DF = next[379: 372];
wire [31:0] Out_register_DSBASE = next[411: 380];
wire [31:0] Out_register_EAX = next[443: 412];
wire [31:0] Out_register_EBP = next[475: 444];
wire [31:0] Out_register_EBX = next[507: 476];
wire [31:0] Out_register_ECX = next[539: 508];
wire [31:0] Out_register_EDI = next[571: 540];
wire [31:0] Out_register_EDX = next[603: 572];
wire [31:0] Out_register_EIP = next[635: 604];
wire [31:0] Out_register_ESBASE = next[667: 636];
wire [31:0] Out_register_ESI = next[699: 668];
wire [31:0] Out_register_ESP = next[731: 700];
wire [31:0] Out_register_FSBASE = next[763: 732];
wire [31:0] Out_register_GSBASE = next[795: 764];
wire Out_register_OF = next[796: 796];
wire Out_register_PF = next[797: 797];
wire Out_register_SF = next[798: 798];
wire [31:0] Out_register_SSBASE = next[830: 799];
wire Out_register_ZF = next[831: 831];
wire [63:0] Out_timestamp = next[895: 832];
wire [119:0] instruction_bits = current[193: 74];
wire [143:0] memory_0 = current[337: 194];
wire [31:0] v30 = memory_0[79: 48];
wire [31:0] pad_49 = (v30[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v31 = { pad_49, v30 };
wire [31:0] pad_51 = (Advice_1[31:31] == 1'b1) ?32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
wire [63:0] v33 = { pad_51, Advice_1 };
wire [63:0] v34 = v31 * v33;
wire [31:0] v35 = v34[31:0];
wire [31:0] v36 = { v35 };
wire [31:0] v38 = ( Advice_2 == 3'd0) ? Out_register_EAX : 
	( Advice_2 == 3'd1) ? Out_register_ECX : 
	( Advice_2 == 3'd2) ? Out_register_EDX : 
	( Advice_2 == 3'd3) ? Out_register_EBX : 
	( Advice_2 == 3'd4) ? Out_register_ESP : 
	( Advice_2 == 3'd5) ? Out_register_EBP : 
	( Advice_2 == 3'd6) ? Out_register_ESI : Out_register_EDI;
wire v39 = v36 == v38;
wire [2:0] v3a = instruction_bits[13: 11];
wire [2:0] v3b = { v3a };
wire [2:0] v3c = 3'b000;
wire v3d = v3b == v3c;
wire v3e = In_register_EAX == Out_register_EAX;
wire v3f = v3d | v3e;
wire [2:0] v40 = 3'b110;
wire v41 = v3b == v40;
wire v42 = In_register_EBX == Out_register_EBX;
wire v43 = v41 | v42;
wire [2:0] v44 = 3'b100;
wire v45 = v3b == v44;
wire v46 = In_register_ECX == Out_register_ECX;
wire v47 = v45 | v46;
wire [2:0] v48 = 3'b010;
wire v49 = v3b == v48;
wire v4a = In_register_EDX == Out_register_EDX;
wire v4b = v49 | v4a;
wire [2:0] v4c = 3'b011;
wire v4d = v3b == v4c;
wire v4e = In_register_ESI == Out_register_ESI;
wire v4f = v4d | v4e;
wire [2:0] v50 = 3'b111;
wire v51 = v3b == v50;
wire v52 = In_register_EDI == Out_register_EDI;
wire v53 = v51 | v52;
wire [2:0] v54 = 3'b001;
wire v55 = v3b == v54;
wire v56 = In_register_ESP == Out_register_ESP;
wire v57 = v55 | v56;
wire [2:0] v58 = 3'b101;
wire v59 = v3b == v58;
wire v5a = In_register_EBP == Out_register_EBP;
wire v5b = v59 | v5a;
wire [31:0] v5c = 32'b11010000000000000000000000000000;
wire [31:0] v5d = In_register_EIP + v5c;
wire v5e = v5d == Out_register_EIP;
wire v5f = In_register_CSBASE == Out_register_CSBASE;
wire v60 = In_register_SSBASE == Out_register_SSBASE;
wire v61 = In_register_ESBASE == Out_register_ESBASE;
wire v62 = In_register_DSBASE == Out_register_DSBASE;
wire v63 = In_register_GSBASE == Out_register_GSBASE;
wire v64 = In_register_FSBASE == Out_register_FSBASE;
wire v65 = In_register_AF == Out_register_AF;
wire [63:0] v66 = 64'b0000000000000000000000000000000111111111111111111111111111111111;
wire [63:0] v67 = v34 + v66;
wire [63:0] v68 = 64'b0000000000000000000000000000000011111111111111111111111111111111;
wire v69 = v67 < v68;
wire v6a = v69 == Out_register_CF;
wire v6b = In_register_DF == Out_register_DF;
wire v6c = v69 == Out_register_OF;
wire v6d = In_register_PF == Out_register_PF;
wire v6e = In_register_SF == Out_register_SF;
wire v6f = In_register_ZF == Out_register_ZF;
wire v70 = v3f & v43 & v47 & v4b & v4f & v53 & v57 & v5b & v5e & v5f & v60 & v61 & v62 & v63 & v64 & v65 & v6a & v6b & v6c & v6d & v6e & v6f;
wire v71 = v39 & v70;
wire [31:0] v72 = instruction_bits[87: 56];
wire v74 = v72 == Advice_1;
wire v75 = 1'b0;
wire v77 = v75 == Out_error_flag;
wire v79 = In_error_flag == v75;
wire [2:0] v7a = instruction_bits[18: 16];
wire [2:0] v7b = { v7a };
wire v7d = v7b == Advice_3;
wire [31:0] v7f = ( Advice_4 == 3'd0) ? In_register_DSBASE : 
	( Advice_4 == 3'd1) ? In_register_DSBASE : 
	( Advice_4 == 3'd2) ? In_register_DSBASE : 
	( Advice_4 == 3'd3) ? In_register_DSBASE : 
	( Advice_4 == 3'd4) ? In_register_SSBASE : 
	( Advice_4 == 3'd5) ? In_register_SSBASE : 
	( Advice_4 == 3'd6) ? In_register_DSBASE : In_register_DSBASE;
wire [31:0] v80 = 32'b00000000000000000000000000000000;
wire [31:0] v81 = ( Advice_3 == 3'd0) ? In_register_EAX : 
	( Advice_3 == 3'd1) ? In_register_ECX : 
	( Advice_3 == 3'd2) ? In_register_EDX : 
	( Advice_3 == 3'd3) ? In_register_EBX : 
	( Advice_3 == 3'd4) ? v80 : 
	( Advice_3 == 3'd5) ? v80 : 
	( Advice_3 == 3'd6) ? In_register_ESI : In_register_EDI;
wire [31:0] v82 = v7f + v81;
wire [31:0] v83 = 32'b00000000000000000000000000000000;
wire [31:0] v85 = v83 << v83;
wire [31:0] v86 = v82 + v85;
wire [31:0] v87 = instruction_bits[55: 24];
wire [31:0] v89 = v86 + v87;
wire v8b = v89 == Advice_5;
wire v8c = v3b == Advice_2;
wire [10:0] v8d = 11'b10010110001;
wire [10:0] v8e = instruction_bits[10: 0];
wire v8f = v8d == v8e;
wire [1:0] v90 = 2'b01;
wire [1:0] v91 = instruction_bits[15: 14];
wire v92 = v90 == v91;
wire [4:0] v93 = 5'b00111;
wire [4:0] v94 = instruction_bits[23: 19];
wire v95 = v93 == v94;
wire [31:0] v96 = instruction_bits[119: 88];
wire v97 = v83 == v96;
wire v98 = 1'b1;
wire v99 = v7b == v54;
wire v9a = v7b == v58;
wire v9b = v99 | v9a;
wire v9c = v9b ^ v98;
wire v9d = v98 & v9c & v98 & v98;
wire v9e = v8f & v92 & v95 & v97 & v9d;
wire [3:0] v9f = 4'b0010;
wire va1 =  v9f == memory_0[15: 12] && Advice_5 == memory_0[47: 16] && In_timestamp == memory_0[143: 80] && 4'd0 == memory_0[11: 8] && 1'b1 == memory_0[0: 0] && 6'b000000 == memory_0[7: 2] && 1'b0 == memory_0[1: 1];
wire [63:0] va2 = 64'b1000000000000000000000000000000000000000000000000000000000000000;
wire [63:0] va3 = In_timestamp + va2;
wire va5 = va3 == Out_timestamp;
wire va6 = v7b == Advice_4;
wire va7 = In_error_flag ^ v98;
wire va8 = va7 | Out_error_flag;
wire va9 = v71 & v74 & v77 & v79 & v7d & v8b & v8c & v9e & va1 & va5 & va6 & va8;
wire rnx46x0 = 1'b0 || va9;
wire onx46x0 = 1'b0 || ( 1'b0 && va9);
wire v2e = (!onx46x0) && rnx46x0;
assign result = v2e;
assign dummy = 1'b0;
endmodule
