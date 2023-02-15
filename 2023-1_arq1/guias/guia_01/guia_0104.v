/* 
    Guia_0104.v

    - Converter valor base binaria para base quaternaria, octal e hexadecimal.
    - Como rodar passando valores por parametro:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp +arg0=VALOR_DO_ARG 
*/

module Guia_0104;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0104";
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
        $display("b(2) = %b", b);
        x = b;
        $display("b = [%2b][%2b][%2b][%2b] = %o %o %o %o (4);", b[7:6], b[5:4], b[3:2], b[1:0], b[7:6], b[5:4], b[3:2], b[1:0]);
        $display("b = [%3b][%3b][%3b] = %o %o %o (8);", b[7:6], b[5:3], b[2:0], b[7:6], b[5:3], b[2:0]);
        $display("b = [%4b][%4b] = %x %x (16)", b[7:4], b[3:0], b[7:4], b[3:0]);
    end
endmodule