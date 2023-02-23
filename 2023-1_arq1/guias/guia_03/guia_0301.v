/* 
    Guia_0201.v

    - Converter valor base decimal para base binaria, 
        considerar partes fracionarias.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0201;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0201";
    integer arg0;

    // define program data 
    integer x;
    reg[7:0] b = 0;

    initial begin
        
        // Buscar valor do parametro se possuir um.
        if ($value$plusargs("arg0=%d", arg0)) begin
            x = arg0; 
        end else begin
            x = 0;
        end

        $display("%s - test", nameProgram);
        $display("x = %d", x);
        $display("b = %8b", b);
        b = x;
        $display("b = %8b", b);
    end
endmodule