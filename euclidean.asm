# xSpim Memory Demo Program

#  Data Area
.data

space:
    .asciiz " "

newline:
    .asciiz "\n"

dispArray_P:
    .asciiz "\nArray P:\n"

dispArray_Q:
    .asciiz "\nArray Q:\n"

convention:
    .asciiz "\nConvention Check\n"

euclideanDistance:
    .asciiz "\nEuclidean Distance:\n"

arrayP:
	.word -20 29 -187 -66 331 39 -220 455 9

arrayQ:
    .word -1 83 190 -49 293 -10 -223 98 -29

#Text Area (i.e. instructions)
.text

main:
    ori     $v0, $0, 4          
    la      $a0, dispArray_P
    syscall

    la      $s0, arrayP
    la      $s1, arrayQ
    ori     $s2, $0, 9 # array size

    add     $a0, $0, $s0
    add     $a1, $0, $s2
 
    jal     DispArray

    la      $a0, dispArray_Q
    syscall

    add     $a0, $0, $s1
    add     $a1, $0, $s2
 
    jal     DispArray

    ori     $s3, $0, 0
    ori     $s4, $0, 0
    ori     $s5, $0, 0
    ori     $s6, $0, 0
    ori     $s7, $0, 0
    
    add     $a0, $0, $s0
    add     $a1, $0, $s1
    add     $a2, $0, $s2

    jal     PrintEuclidean

    add     $s3, $s3, $v0
    add     $s3, $s3, $s4
    add     $s3, $s3, $s5
    add     $s3, $s3, $s6
    add     $s3, $s3, $s7

    ori     $v0, $0, 4          
    la      $a0, euclideanDistance
    syscall

    ori     $v0, $0, 1
    add     $a0, $0, $s3
    syscall

    ori     $v0, $0, 4          
    la      $a0, newline
    syscall

    j       Exit

DispArray:
    addi    $t0, $0, 0 
    add     $t1, $0, $a0

dispLoop:
    beq     $t0, $a1, dispend
    sll     $t2, $t0, 2
    add     $t3, $t1, $t2
    lw      $t4, 0($t3)

    ori     $v0, $0, 1
    add     $a0, $0, $t4
    syscall

    ori     $v0, $0, 4
    la      $a0, space
    syscall

    addi    $t0, $t0, 1
    j       dispLoop    

dispend:
    ori     $v0, $0, 4
    la      $a0, newline
    syscall
    jr      $ra 

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi $v0, $zero, -1
    addi $v1, $zero, -1
    addi $a0, $zero, -1
    addi $a1, $zero, -1
    addi $a2, $zero, -1
    addi $a3, $zero, -1
    addi $k0, $zero, -1
    addi $k1, $zero, -1
    jr      $ra

Squared:
    mult $a0, $a0
    mflo $v0

    addiu $sp, $sp, -8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
    move $s0, $v0

    jal ConventionCheck

    move $v0, $s0
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addiu $sp, $sp, 8

    jr $ra
    
SquareRoot:
    # using $t0-3
    move $t0, $a0
    move $t1, $zero
    move $t2, $a0,
    li $t9, 2
    div $a0, $t9
    mflo $t3

sqrtLoop:
    div $t0, $t2
    mflo $t4
    add $t4, $t4, $t2
    div $t4, $t9
    mflo $t2
    addiu $t1, $t1, 1
    bge $t1, $t3, sqrtEnd
    j sqrtLoop

sqrtEnd:
    move $v0, $t2

    addiu $sp, $sp, -8
    sw $s0, 0($sp)
    sw $ra, 4($sp)
    move $s0, $v0

    jal ConventionCheck

    move $v0, $s0
    lw $s0, 0($sp)
    lw $ra, 4($sp)
    addiu $sp, $sp, 8

    jr $ra

Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

PrintEuclidean:
    # TODO: write your code here
    # $a0 stores the address of the arrayP
    # $a1 stores the address of the arrayQ 
    # $a2 stores the n in given n-dimensional Euclidean space
	
    addiu $sp, $sp, -36         # store the registers that will be messed up
    sw $ra, 0($sp)  
    sw $s0, 4($sp)              # $s0 = d
    sw $s1, 8($sp)              # $s1 = pi
    sw $s2, 12($sp)             # $s2 = qi
    sw $s3, 16($sp)             # $s3 = pi - qi
    sw $s4, 20($sp)     
    sw $s5, 24($sp)             # $s5 = $a0
    sw $s6, 28($sp)             # $s6 = $a1
    sw $s7, 32($sp)             # $s7 = $a2
    li $s4, 0                   # $s4 = 0 = i
    li $s0, 0
    move $s5, $a0
    move $s6, $a1
    move $s7, $a2
Loop:
    bge $s4, $s7, sqrt
    lw $s1, 0($s5)              # $s1 = p[i]
    lw $s2, 0($s6)              # $s2 = q[i]
    sub $s3, $s1, $s2           # $s3 = p[i] - q[i]

    move $a0, $s3

    jal Squared

    move $s3, $v0               # $s3 = (p[i] - q[i])^2
    
	li $v0, 1
	move $a0, $s3
	syscall                     # print out (p[i] - q[i])^2

    add $s0, $s0, $s3           # $s0 = sum of (p[i] - q[i])^2

    addi $s4, $s4, 1            # i++
    addiu $s5, $s5, 4           # arrP[i + 1]
    addiu $s6, $s6, 4           # arrQ[i + 1]

    j Loop
sqrt:
    move $a0, $s0

    jal SquareRoot
    
OUT:       
    lw $ra, 0($sp)  
    lw $s0, 4($sp)             
    lw $s1, 8($sp)           
    lw $s2, 12($sp)            
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    lw $s5, 24($sp)             
    lw $s6, 28($sp)             
    lw $s7, 32($sp) 
    addiu $sp, $sp, 36
    # Do not remove this line
    jr      $ra
