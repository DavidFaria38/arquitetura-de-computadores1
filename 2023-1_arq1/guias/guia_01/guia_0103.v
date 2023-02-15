/* 
    Guia_0103.v

    - Converter valor base binaria para base decimal.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0103;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0103";
    integer arg0;

    // define program data 
    integer x;
    reg[7:0] b = 8'b0000_0000;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%d", arg0)) begin
            x = arg0; 
        end

        $display("%s - test", nameProgram);
        $display("x(10) = %d", x);
        b = x;
        $display("b = %8b (2); b = %o (8); b = %x (16)", b, b, b, b);
    end
endmodule