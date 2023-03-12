/* 
    
    Guia_0606.v
    Nome: David de Sá Vieira de Faria
    Matricula: 699415

    - Como rodar:
        1. compilar:    iverilog -o .\NOME.vvp .\NOME.v
        2. rodar:       vvp .\NOME.vvp
*/

/*
    Tabela verdade para seguinte expressao:
    expressao: ((y'+w+z')'.(xyw')')+(ywz+x')'
               (~(~y|w|~x)&~(x&y&~w))|~((y&w&z)|~x)
    Tabela verdade: 
     # x y w z s                               
    00 0 0 0 0 0     xy\wz 00 01 11 10                          
    01 0 0 0 1 0        00  0  0  0  0           
    02 0 0 1 0 0        01  0  0  0  0           
    03 0 0 1 1 0        11  1  1  0  1          
    04 0 1 0 0 0        10  1  1  1  1          
    05 0 1 0 1 0
    06 0 1 1 0 0     PoS
    07 0 1 1 1 0     Conjuntos: (0,1,2,3,4,5,6,7), (7,15)
    08 1 0 0 0 1     Exp.Simp.: x . y'+w'+z'
    09 1 0 0 1 1                x & (~y|~w|~z)
    10 1 0 1 0 1
    11 1 0 1 1 1
    12 1 1 0 0 1
    13 1 1 0 1 1
    14 1 1 1 0 1
    15 1 1 1 1 0         
*/

/* expressao nao otimizada - por extenso */
module expresao_aa (
            output s, 
            input x,
            input y,
            input w,
            input z);
    assign s = (~(~y|w|~x)&~(x&y&~w))|~((y&w&z)|~x);
endmodule

/* expressao nao otimizada - por blocos logicos */
module expresao_ab (
            output s, 
            input x,
            input y,
            input w,
            input z);
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12;

    or  (s, w1, w2);
    and (w1, w3, w4);
    not (w3, w5);
    not (w4, w6);
    or  (w5, w, w8, w9);
    not (w8, y);
    not (w9, x);
    or  (w6, x, y, w10);
    not (w10, w);
    not (w2, w7);
    or  (w7, w11, w12);
    and (w11, y, w, z);
    not (w12, x);
endmodule

/* expressao otimizada - por extenso */
module expresao_ba (
            output s, 
            input x,
            input y,
            input w,
            input z);
    assign s = x & (~y|~w|~z);
endmodule

/* expressao otimizada - por blocos logicos */
module expresao_bb (
            output s, 
            input x,
            input y,
            input w,
            input z);
    wire w1, w2, w3, w4;

    and (s, x, w1);
    or  (w1, w2, w3, w4);
    not (w2, y);
    not (w3, w);
    not (w4, z);
endmodule

module Guia_0606;
    // define my data
    reg[8*9:1] nameProgram = "Guia_0606";

    // define program data 
    reg x, y, w, z;
    wire aa, ab, ba, bb;
    
    expresao_aa expressao_nao_simplificada_A(aa, x, y, w, z); // expressao original formula
    expresao_ab expressao_nao_simplificada_B(ab, x, y, w, z); // expressao original gates
    expresao_ba expressao_simplificada_A(ba, x, y, w, z);     // expressao simplificada formula
    expresao_bb expressao_simplificada_B(bb, x, y, w, z);     // expressao simplificada gates

    initial begin
        
        $display("%s - test", nameProgram);

        $display("x\ty\tw\tz\taa\tab\tba\tbb\t");
        $monitor("%1b\t%1b\t%1b\t%1b\t%1b\t%1b\t%1b\t", x, y, w, z, aa, ab, ba, bb);

        x=1'b0; y=1'b0; w=1'b0; z=1'b0; #1
        x=1'b0; y=1'b0; w=1'b0; z=1'b1; #1
        x=1'b0; y=1'b0; w=1'b1; z=1'b0; #1
        x=1'b0; y=1'b0; w=1'b1; z=1'b1; #1
        x=1'b0; y=1'b1; w=1'b0; z=1'b0; #1
        x=1'b0; y=1'b1; w=1'b0; z=1'b1; #1
        x=1'b0; y=1'b1; w=1'b1; z=1'b0; #1
        x=1'b0; y=1'b1; w=1'b1; z=1'b1; #1
        x=1'b1; y=1'b0; w=1'b0; z=1'b0; #1
        x=1'b1; y=1'b0; w=1'b0; z=1'b1; #1
        x=1'b1; y=1'b0; w=1'b1; z=1'b0; #1
        x=1'b1; y=1'b0; w=1'b1; z=1'b1; #1
        x=1'b1; y=1'b1; w=1'b0; z=1'b0; #1
        x=1'b1; y=1'b1; w=1'b0; z=1'b1; #1
        x=1'b1; y=1'b1; w=1'b1; z=1'b0; #1
        x=1'b1; y=1'b1; w=1'b1; z=1'b1;
    end
endmodule
