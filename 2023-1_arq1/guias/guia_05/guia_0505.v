/* 
    
    Guia_0505.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Utilizando apenas portas nativas NOR, crie um módulo equivalente à expressão:
          (~(a ^ b) = a xnor b)
    - Como rodar:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp
*/

/*
    Tabela verdade para seguinte expressao:
    s =  ~(x ^ y)
    =========
    x   y   s
    0   0   1
    0   1   0
    1   0   0
    1   1   1
*/
module f5a (
            output s, 
            input x,
            input y);
    assign s =  ~(x ^ y);
endmodule

module f5b (
            output s, 
            input x,
            input y);
    wire nor_1;
    wire nor_2;
    wire nor_3;

    nor (nor_1, x, y);
    nor (nor_2, x, nor_1);
    nor (nor_3, y, nor_1);
    nor (s, nor_2, nor_3);

endmodule

module Guia_0505;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0505";

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