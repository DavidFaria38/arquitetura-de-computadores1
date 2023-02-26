/* 
    Guia_0203.v
    
    699415 - David de Sá Vieira de Faria

    - Converter valor base binaria para base 4, base 8 e base 16, 
        considerarando partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0203;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0203";
    reg[7:0] arg0;
    reg[7:0] arg1;

    // define program data 
    integer i = 7;
    real num = 0;
    real power2 = 1.0;
    reg[7:0] bi_num = 8'b0000_0000; // parte inteira do numero
    reg[7:0] bi_num_frac = 8'b0000_0000; // parte fracionaria do numero

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            bi_num = arg0; 
        end 
        if ($value$plusargs("arg1=%b", arg1)) begin
            bi_num_frac = arg1; 
        end 

        $display("%s - test", nameProgram);

        $display("bin = [%4b][%4b].[%4b][%4b] (2)", bi_num[7:4], bi_num[3:0], bi_num_frac[7:4], bi_num_frac[3:0]);
        $display("\t\t%o%o%o%o.%o%o%o%o (4)", bi_num[7:6], bi_num[5:4], bi_num[3:2], bi_num[1:0], bi_num_frac[7:6], bi_num_frac[5:4], bi_num_frac[3:2], bi_num_frac[1:0]);
        $display("\t\t%o%o%o.%o%o%o (8)", bi_num[7:6], bi_num[5:3], bi_num[2:0], bi_num_frac[7:5], bi_num_frac[4:2], bi_num_frac[1:0]);
        $display("\t\t%x%x.%x%x (16)", bi_num[7:4], bi_num[3:0], bi_num_frac[7:4], bi_num_frac[3:0]);
    end
endmodule