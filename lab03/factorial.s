.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    # s0 -> res, s1 -> n
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp) 
    addi s0, x0 ,1
    addi s1, a0, 0
loop:
    beq s1, x0, exit
    mul s0, s0, s1
    addi s1, s1, -1
    jal x0, loop
    
exit:
    addi a0, s0, 0
    lw s0 4(sp)
    lw ra 0(sp)
    addi sp, sp, 8
    jr ra
