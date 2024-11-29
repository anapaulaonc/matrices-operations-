.data
matriz1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9    # Primeira matriz 3x3
matriz2: .word 9, 8, 7, 6, 5, 4, 3, 2, 1    # Segunda matriz 3x3
vetor1: .space 36                           # Vetor para armazenar os elementos da matriz1
vetor2: .space 36                           # Vetor para armazenar os elementos da matriz2
vetor_result: .space 36                     # Vetor para armazenar os resultados da soma
space: .string " "                          # Espaço entre elementos
newline: .string "\n"                       # Nova linha (não será usada para separar)

.text
.globl main
main:
    # Copia os elementos da matriz1 para o vetor1
    la t0, matriz1          # Endereço inicial da matriz1
    la t1, vetor1           # Endereço inicial do vetor1
    li t2, 9                # Número total de elementos (3x3)

copy_loop1:
    lw t3, 0(t0)            # Lê o próximo elemento da matriz1
    sw t3, 0(t1)            # Armazena o elemento no vetor1
    addi t0, t0, 4          # Avança para o próximo elemento na matriz1
    addi t1, t1, 4          # Avança para o próximo endereço no vetor1
    addi t2, t2, -1         # Decrementa o contador de elementos
    bnez t2, copy_loop1     # Continua até copiar todos os elementos

    # Copia os elementos da matriz2 para o vetor2
    la t0, matriz2          # Endereço inicial da matriz2
    la t1, vetor2           # Endereço inicial do vetor2
    li t2, 9                # Número total de elementos (3x3)

copy_loop2:
    lw t3, 0(t0)            # Lê o próximo elemento da matriz2
    sw t3, 0(t1)            # Armazena o elemento no vetor2
    addi t0, t0, 4          # Avança para o próximo elemento na matriz2
    addi t1, t1, 4          # Avança para o próximo endereço no vetor2
    addi t2, t2, -1         # Decrementa o contador de elementos
    bnez t2, copy_loop2     # Continua até copiar todos os elementos

    # Soma os elementos correspondentes de vetor1 e vetor2, armazenando em vetor_result
    la t0, vetor1           # Endereço inicial do vetor1
    la t1, vetor2           # Endereço inicial do vetor2
    la t2, vetor_result     # Endereço inicial do vetor_result
    li t3, 9                # Número total de elementos (3x3)

sum_loop:
    lw t4, 0(t0)            # Lê o próximo elemento de vetor1
    lw t5, 0(t1)            # Lê o próximo elemento de vetor2
    add t6, t4, t5          # Soma os dois elementos
    sw t6, 0(t2)            # Armazena o resultado no vetor_result
    addi t0, t0, 4          # Avança para o próximo elemento no vetor1
    addi t1, t1, 4          # Avança para o próximo elemento no vetor2
    addi t2, t2, 4          # Avança para o próximo endereço no vetor_result
    addi t3, t3, -1         # Decrementa o contador de elementos
    bnez t3, sum_loop       # Continua até somar todos os elementos

    # Imprime os elementos de vetor_result
    la t0, vetor_result     # Endereço inicial do vetor_result
    li t1, 9                # Número total de elementos a imprimir

print_loop:
    lw t3, 0(t0)            # Lê o próximo elemento do vetor_result
    li a7, 1                # Syscall para imprimir inteiro
    mv a0, t3               # Move o valor para a0
    ecall                   # Imprime o inteiro

    la a0, space            # Carrega o espaço para separação
    li a7, 4                # Syscall para imprimir string
    ecall

    addi t0, t0, 4          # Avança para o próximo elemento no vetor_result
    addi t1, t1, -1         # Decrementa o contador de elementos
    bnez t1, print_loop     # Continua até imprimir todos os elementos

    # Encerra o programa
    li a7, 10               # Syscall para encerrar o programa
    ecall
