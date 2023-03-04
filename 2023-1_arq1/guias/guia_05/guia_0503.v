/* 
    
    Guia_0503.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Utilizando apenas portas nativas NOR, crie um módulo equivalente à expressão:
         (a | ~b)
    - Como rodar:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp
*/

module f5a (
            output s, 
            input x,
            input y);
    assign s =  (x | ~y);
endmodule

/*
    s =  (x | ~y)
    =========
    x   y   s
    0   0   1
    0   1   0
    1   0   1
    1   1   1
*/
module f5b (
            output s, 
            input x,
            input y);
    wire nor_1;
    wire nor_2;

    nor(nor_1, y, y);
    nor(nor_2, x, nor_1);
    nor(s, nor_2, nor_2);
endmodule

module Guia_0503;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0503";

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