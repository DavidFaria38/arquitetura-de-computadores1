/* 
    Guia_0102.v

    - Converter valor base binaria para base decimal.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0102;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0102";
    integer arg0;

    // define program data 
    integer x = 0;
    reg[7:0] b = 8'b0000_0000;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%b", arg0)) begin
            b = arg0; 
        end

        $display("%s - test", nameProgram);
        $display("b(2) = %8b", b);
        x = b;
        $display("b(10) = %d", x);
    end
endmodule