/* 
    
    Guia_0506.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Utilizando apenas portas nativas NAND, crie um módulo equivalente à expressão:
          (a ^ b = a xor b)
    - Como rodar:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp
*/

/*
    Tabela verdade para seguinte expressao:
    s =  (x ^ y)
    =========
    x   y   s
    0   0   0
    0   1   1
    1   0   1
    1   1   0
*/
module f5a (
            output s, 
            input x,
            input y);
    assign s =  (x ^ y);
endmodule

module f5b (
            output s, 
            input x,
            input y);
    wire nand_1;
    wire nand_2;
    wire nand_3;

    nand (nand_1, x, y);
    nand (nand_2, nand_1, x);
    nand (nand_3, nand_1, y);
    nand (s, nand_2, nand_3);
endmodule

module Guia_0506;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0506";

    // define program data 
    reg x;
    reg y;
    wire a, b;
    
    f5a moduleA(a, x, y);
    f5b moduleB(b, x, y);

    initial begin
        
        $display("%s - test", nameProgram);

        $display("x\ty\ta\tb\t");
        $monitor("%1b\t%1b\t%1b\t%1b\t", x, y, a, b);

        x=1'b0; y=1'b0; #1
        x=1'b0; y=1'b1; #1
        x=1'b1; y=1'b0; #1
        x=1'b1; y=1'b1;
    end
endmodule