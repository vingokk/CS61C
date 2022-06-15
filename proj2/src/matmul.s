.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:


    # Error checks
    #1
    slti t0, a1, 1
    slti t1, a2, 1
    or t2, t0, t1
    bne t2, x0, exit1

    #2
    slti t0, a4, 1
    slti t1, a5, 1
    or t2, t0, t1
    bne t2, x0, exit2

    # w0 != h1
    bne a2, a4, exit3

    # Prologue
    addi sp sp -16
    sw ra 12(sp)
    sw s0 8(sp)
    sw s1 4(sp)
    sw s2 0(sp)

    mv s0 x0 # i
    mv s1 x0 # j
    mv s2 x0 # D(i, j)

outer_loop_start:

    slt t0, s0, a1 # i < height0
    beq t0, x0, outer_loop_end

inner_loop_start:
    slt t1, s1, a5 # j < weight1
    beq t1, x0, inner_loop_end

    #call dot multiplication
    addi sp sp -24
    sw ra 20(sp)
    sw a0 16(sp)
    sw a1 12(sp)
    sw a2 8(sp)
    sw a3 4(sp)
    sw a4 0(sp)

    mul t2 a2 s0 # m0 = w0 * j
    slli t2 t2 2
    add a0 a0 t2

    slli t3 s1 2 # m1 = m1 + j
    add a1 a3 t3
    
    mv a2 a2 # w0
    li a3 1  #

    mv a4 a5 # s1 = w1

    jal ra dot
    mv s2 a0 # D(i,j)
    sw s2 0(a6) #d.append(D(i,j)
    addi a6 a6 4

    lw a4 0(sp)
    lw a3 4(sp)
    lw a2 8(sp)
    lw a1 12(sp)
    lw a0 16(sp)
    lw ra 20(sp)
    addi sp sp 24

    addi s1, s1, 1
    jal x0, inner_loop_start

inner_loop_end:

    mv s1 x0 # j = 0
    addi s0, s0, 1 # i += 1
    jal x0, outer_loop_start

outer_loop_end:

    # Epilogue
    lw s2 0(sp)
    lw s1 4(sp)
    lw s0 8(sp)
    addi sp sp 16
    ret
    
exit1:
    addi a1, x0, 2
    addi a0, x0, 17
    ecall

exit2:
    addi a1, x0, 3
    addi a0, x0, 17
    ecall

exit3:
    addi a1, x0, 4
    addi a0, x0, 17
    ecall
