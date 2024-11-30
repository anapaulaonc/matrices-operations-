.data
matriz1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9    # Primeira matriz 3x3
matriz2: .word 9, 8, 7, 6, 5, 4, 3, 2, 1    # Segunda matriz 3x3
vetor1: .space 36                           # Vetor para armazenar os elementos da matriz1
vetor2: .space 36                           # Vetor para armazenar os elementos da matriz2
vetor_result: .space 36                     # Vetor para armazenar os resultados da soma
vetor_produto: .space 36                    # Vetor para armazenar os resultados da multiplicação
msg_opcoes: .string "Escolha uma opcao:\n1 - Somar Matrizes\n2 - Imprimir Matriz 1\n3 - Multiplicar Matrizes\n"
msg_soma: .string "Resultado da soma:\n"
msg_matriz1: .string "Primeira matriz:\n"
msg_produto: .string "Resultado da multiplicacao:\n"
msg_invalida: .string "Opcao invalida\n"
space: .string " "                          # Espaço entre elementos
newline: .string "\n"                       # Nova linha

.text
.globl main
main:
    # Exibe o painel de opções
    la a0, msg_opcoes       # Mensagem com as opções
    li a7, 4                # Syscall para imprimir string
    ecall

    # Lê a escolha do usuário
    li a7, 5                # Syscall para ler um inteiro
    ecall
    mv t0, a0               # Move a entrada para t0

    # Verifica a escolha do usuário
    li t1, 1                # Verifica se a escolha é 1
    beq t0, t1, opcao_soma  # Se for 1, vai para soma

    li t1, 2                # Verifica se a escolha é 2
    beq t0, t1, opcao_matriz1 # Se for 2, vai para imprimir matriz1

    li t1, 3                # Verifica se a escolha é 3
    beq t0, t1, opcao_multiplicacao # Se for 3, vai para multiplicação

    # Caso contrário, opção inválida
    la a0, msg_invalida
    li a7, 4
    ecall
    j main                  # Retorna ao painel inicial

opcao_soma:
    # Soma as matrizes e imprime o resultado
    la a0, msg_soma
    li a7, 4
    ecall
    j soma_matrizes

opcao_matriz1:
    # Imprime a primeira matriz
    la a0, msg_matriz1
    li a7, 4
    ecall
    j imprimir_matriz1

opcao_multiplicacao:
    # Multiplica as matrizes e imprime o resultado
    la a0, msg_produto
    li a7, 4
    ecall
    j multiplicar_matrizes

# Soma das matrizes
soma_matrizes:
    la t0, matriz1          # Endereço inicial da matriz1
    la t1, matriz2          # Endereço inicial da matriz2
    la t2, vetor_result     # Endereço inicial do vetor_result
    li t3, 9                # Número total de elementos (3x3)

soma_loop:
    lw t4, 0(t0)            # Lê o próximo elemento de matriz1
    lw t5, 0(t1)            # Lê o próximo elemento de matriz2
    add t6, t4, t5          # Soma os dois elementos
    sw t6, 0(t2)            # Armazena o resultado no vetor_result
    addi t0, t0, 4          # Avança para o próximo elemento na matriz1
    addi t1, t1, 4          # Avança para o próximo elemento na matriz2
    addi t2, t2, 4          # Avança para o próximo endereço no vetor_result
    addi t3, t3, -1         # Decrementa o contador de elementos
    bnez t3, soma_loop      # Continua até somar todos os elementos

    # Imprime o resultado da soma
    la t0, vetor_result
    li t1, 9
    j print_loop
# Multiplicação das matrizes utilizando vetores
multiplicar_matrizes:
    la t0, matriz1          # Endereço inicial da matriz1
    la t1, matriz2          # Endereço inicial da matriz2
    la t2, vetor_produto    # Endereço inicial do vetor_produto
    li t3, 9                # Número total de elementos (3x3)

multiplicacao_loop:
    lw t4, 0(t0)            # Lê o próximo elemento da matriz1
    lw t5, 0(t1)            # Lê o próximo elemento da matriz2
    mul t6, t4, t5          # Multiplica os elementos (t6)
    sw t6, 0(t2)            # Armazena o resultado no vetor_produto

    addi t0, t0, 4          # Avança para o próximo elemento na matriz1
    addi t1, t1, 4          # Avança para o próximo elemento na matriz2
    addi t2, t2, 4          # Avança para o próximo endereço no vetor_produto
    addi t3, t3, -1         # Decrementa o contador de elementos
    bnez t3, multiplicacao_loop  # Continua até multiplicar todos os elementos

    # Imprime o resultado da multiplicação
    la t0, vetor_produto
    li t1, 9
    j print_loop


# Imprime a matriz1
imprimir_matriz1:
    la t0, matriz1          # Endereço inicial da matriz1
    li t1, 9
    j print_loop

# Loop de impressão (com quebra de linha)
print_loop:
    lw t3, 0(t0)            # Lê o próximo elemento
    li a7, 1                # Syscall para imprimir inteiro
    mv a0, t3
    ecall

    addi t1, t1, -1         # Decrementa o contador
    addi t0, t0, 4          # Avança para o próximo elemento

    # Verifica se precisa imprimir quebra de linha
    li t5, 3                # Carrega o valor 3 em t5
    rem t4, t1, t5          # t4 = t1 % t5
    la a0, newline          # Imprime nova linha
    li a7, 4
    ecall
    j print_continue

print_space:
    la a0, space            # Imprime espaço
    li a7, 4
    ecall

print_continue:
    bnez t1, print_loop     # Continua o loop de impressão

    # Finaliza o programa
    li a7, 10               # Syscall para encerrar o programa
    ecall
