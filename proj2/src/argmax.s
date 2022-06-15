.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:

    # Prologue
    slti t0, a1, 1 # length < 1
    bne t0, x0, exit 
    addi sp, sp, -8
    sw s0, 4(sp) # s0-> temp
    sw s1, 0(sp) # s1 -> i
    addi s0, x0, 0
    addi s1, x0, 0

loop_start:
    slt t0, s1, a1 # i < length
    beq t0, x0, loop_end 
    
    slli t0, s0, 2 # temp *= 4
    add  t0, t0, a0 # temp + arr
    slli t1, s1, 2 # i *= 4
    add  t1, t1, a0 # i + arr
    lw t0, 0(t0) # array[temp]
    lw t1, 0(t1) # array[i]
    slt t2, t0, t1 # arrat[temp] < array[i]
    bne t2, x0, loop_continue
    addi s1, s1, 1
    jal x0, loop_start

loop_continue:
    addi s0, s1, 0 # temp = i
    addi s1, s1, 1 # i += 1
    jal x0, loop_start

loop_end:
    # Epilogue
    addi a0, s0, 0
    addi sp, sp, 8
    ret

exit:
    addi a1, x0, 7
    addi a0, x0, 17
    ecall
