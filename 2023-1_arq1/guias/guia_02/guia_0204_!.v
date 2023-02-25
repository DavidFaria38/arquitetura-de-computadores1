/* 
    Guia_0204.v

    - Converter valor base binaria para base 4, base 8 e base 16, 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0204;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0204";
    reg[15:0] arg0;
    reg[15:0] arg1;
    reg[15:0] arg2;
    reg[15:0] arg3;
    reg[15:0] arg4;
    reg[15:0] arg5;

    // define program data 
    reg[15:0] bin_num; // parte inteira do numero base quaternaria 
    reg[15:0] bin_num_frac; // parte fracionaria do numero base quaternaria
    reg[15:0] qua_num; // parte inteira do numero base quaternaria 
    reg[15:0] qua_num_frac; // parte fracionaria do numero base quaternaria
    reg[15:0] oct_num; // parte inteira do numero base octal
    reg[15:0] oct_num_frac; // parte fracionaria do numero base octal
    reg[15:0] hex_num; // parte inteira do numero base hexadecimal
    reg[15:0] hex_num_frac; // parte fracionaria do numero base hexadecimal

    // decimal

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%d", arg0)) begin
            qua_num = arg0; 
        end 
        if ($value$plusargs("arg1=%d", arg1)) begin
            qua_num_frac = arg1; 
        end 
        if ($value$plusargs("arg2=%o", arg2)) begin
            oct_num = arg2; 
        end 
        if ($value$plusargs("arg3=%o", arg3)) begin
            oct_num_frac = arg3; 
        end 
        if ($value$plusargs("arg4=%x", arg4)) begin
            hex_num = arg4; 
        end 
        if ($value$plusargs("arg5=%x", arg5)) begin
            hex_num_frac = arg5; 
        end 

        $display("%s - test", nameProgram);
        // [00][00]_[00][00] = [0][0][0][0]
        bin_num[7:6] = qua_num[3]; bin_num_frac[7:6] = qua_num_frac[3];
        bin_num[5:4] = qua_num[2]; bin_num_frac[5:4] = qua_num_frac[2];
        bin_num[3:2] = qua_num[1]; bin_num_frac[3:2] = qua_num_frac[1];
        bin_num[1:0] = qua_num[0]; bin_num_frac[1:0] = qua_num_frac[0];
        
        $display ( "input = %d.%d (4) => %b.%b (2)", qua_num, qua_num_frac, bin_num, bin_num_frac);
        // $display ( "\t\t%o.%o (8)", num, num_frac );
        // $display ( "\t\t%x.%x (16)", num, num_frac );

    end
endmodule