
.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================

dot:
    slti t0, a2, 1
    bne t0, x0, exit1

    slti t0, a3, 1
    slti t1, a4, 1
    or t2, t0, t1
    bne t2, x0, exit2

    # Prologue
    addi sp, sp, -8
    sw s0, 4(sp)
    sw s1, 0(sp)
    mv s0, x0 # s0 -> i = 0
    mv s1, x0 # s1 -> res = 0

loop_start:
    slt t0, s0, a2
    beq t0, x0, loop_end

    #v1[i * s]
    mul t0, s0, a3
    slli t0, t0, 2
    add  t0, t0, a0
    lw t0 0(t0)

    #v2[i * s]
    mul t1, s0, a4
    slli t1, t1, 2
    add t1, t1, a1
    lw t1 0(t1)

    #res = v1[i*s] * v2[i*s]
    mul t2, t0, t1
    add s1, s1, t2
    
    #i = i+1
    addi s0, s0, 1
    jal x0, loop_start

loop_end:


    # Epilogue
    mv a0, s1
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 8
    ret

exit1:
    addi a1, x0, 5
    addi a0, x0, 17
    ecall

exit2:
    addi a1, x0, 6
    addi a0, x0, 17
    ecall

 
