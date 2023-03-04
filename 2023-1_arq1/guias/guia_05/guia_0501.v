/* 
    
    Guia_0501.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Utilizando apenas portas nativas NOR, crie um módulo equivalente à expressão. 
        (~a & ~b)
    - Como rodar:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp
*/

module f5a (
            output s, 
            input a,
            input b);
    assign s = (~a & ~b);
endmodule

module f5b (
            output s, 
            input a,
            input b);
    
    nor(s, a, b);
endmodule

module Guia_0501;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0501";

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