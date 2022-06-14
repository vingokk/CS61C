
globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#       a0 (int*) is the pointer to the array
#       a1 (int)  is the # of elements in the array
# Returns:
#       None
#
# If the length of the vector is less than 1,
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue 
    slti t0, a1, 1
    bne t0, x0, exit
    addi sp, sp, -4
    sw s0, 0(sp)
    addi s0, x0, 0 # s0 -> i

loop_start:
    ebreak
    slt t2, s0, a1 # t1 -> i < a1
    beq t2, x0, loop_end
    
    lw t0, 0(a0) # t0 -> array[i]
    slt t1, t0, x0 # t1 -> array[i] < 0
    beq t1, x0, loop_continue
    sw x0, 0(a0) # 
    addi a0, a0, 4 #
    addi s0, s0, 1 # i = i + 1
    jal x0, loop_start

loop_continue:
    addi a0, a0, 4 #
    addi s0, s0, 1 # i = i + 1
    jal x0, loop_start

loop_end:
    # Epilogue
    lw s0, 0(sp)
    addi sp, sp, 4
    ret
    
exit:
    ebreak
    addi a1, x0, 8
    addi a0, x0, 17
    ecall
