.data
matriz: .word 1, 2, 3, 4, 5, 6, 7, 8, 9   # Matriz 3x3 armazenada como uma sequência de palavras
newline: .string "\n"                     # Caracter de nova linha para formatação
space: .string " "                        # Espaço entre elementos da matriz

.text
.globl main
main:
    la t0, matriz          # Carrega o endereço inicial da matriz em t0
    li t1, 3               # Número de colunas (e linhas) da matriz
    li t2, 0               # Contador de linhas

outer_loop:
    li t3, 0               # Reinicia o contador de colunas

inner_loop:
    lw t4, 0(t0)           # Lê o próximo elemento da matriz
    addi t0, t0, 4         # Avança para o próximo elemento
    li a7, 1               # Chamada de impressão de inteiro
    mv a0, t4              # Carrega o valor do elemento em a0
    ecall                  # Syscall para imprimir o inteiro

    la a0, space           # Carrega o espaço para separação
    li a7, 4               # Chamada para imprimir string
    ecall

    addi t3, t3, 1         # Incrementa o contador de colunas
    blt t3, t1, inner_loop # Continua até imprimir todos os elementos da linha

    la a0, newline         # Imprime nova linha após terminar uma linha
    li a7, 4               # Chamada para imprimir string
    ecall

    addi t2, t2, 1         # Incrementa o contador de linhas
    blt t2, t1, outer_loop # Continua até imprimir todas as linhas

    li a7, 10              # Chamada para encerrar o programa
    ecall