/* 
    Guia_0301.v

    - Determinar o complemento para os valores e as quantidades de bits indicada
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0301;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0301";
    reg[7:0] arg0;

    // define program data 
    reg[7:0] bin_num = 8'b0000_0000;
    reg[7:0] bin_num_C1;
    reg[7:0] bin_num_C2;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            bin_num = arg0; 
        end

        $display("%s - test", nameProgram);
        
        bin_num_C1 = ~bin_num;
        bin_num_C2 = bin_num_C1 + 1;
        $display( "a = %b (2) -> C1(a) = %b (2) -> C2(a) %b (2)", bin_num, bin_num_C1, bin_num_C2);
    end
endmodule