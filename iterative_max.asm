# xSpim Memory Demo Program

#  Data Area
.data

space:
    .asciiz " "

newline:
    .asciiz "\n"

dispArray:
    .asciiz "\nCurrent Array:\n"

convention:
    .asciiz "\nConvention Check\n"

myArray:
	.word 0 33 123 -66 332 -1 -223 453 9 45 -78 -14  

#Text Area (i.e. instructions)
.text

main:
    ori     $v0, $0, 4          
    la      $a0, dispArray 
    syscall

    ori     $s1, $0, 12
    la      $s0, myArray

    add     $a1, $0, $s1
    add     $a0, $0, $s0
 
    jal     DispArray

    ori     $s2, $0, 0
    ori     $s3, $0, 0
    ori     $s4, $0, 0
    ori     $s5, $0, 0
    ori     $s6, $0, 0
    ori     $s7, $0, 0
    
    add     $a1, $0, $s1
    add     $a0, $0, $s0

    jal     IterativeMax

    add     $s1, $s1, $s2
    add     $s1, $s1, $s3
    add     $s1, $s1, $s4
    add     $s1, $s1, $s5
    add     $s1, $s1, $s6
    add     $s1, $s1, $s7

    add     $a1, $0, $s1
    add     $a0, $0, $s0
    jal     DispArray

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
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

IterativeMax:
    #TODO: write your code here, $a0 = address of the array, $a1 = length of the array
    li $t0, -2147483648     # $t0 = most negative int -2^31 = max
    li $t7, 0               # $t0 = 0 = index i checking for loop condition
Loop:   
    bge $t7, $a1, OUT
    lw $t4, 0($a0)          # $t4 = arr[i]
    move $t5, $a0           # $t5 = arr
	li $v0, 1
	move $a0, $t4
	syscall
	move $a0, $t5           # print out the current element of arr
    move $t5, $a0 
    li $v0, 4
    la $a0, newline
    syscall
    move $a0, $t5
Greater:
    blt $t4, $t0, notGreater
    lw $t0, 0($a0)          # max = arr[i]
    move $t5, $a0           # $t5 = arr
	li $v0, 1
	move $a0, $t0
	syscall
	move $a0, $t5           # print out the new IterativeMax
    j End
notGreater:
    move $t5, $a0           # $t5 = arr
	li $v0, 1
	move $a0, $t0
	syscall
	move $a0, $t5 
End:
    addiu $sp, $sp, -24
    sw $ra, 0($sp)          # save $t0, $a0, $a1, $t4
    sw $t0, 4($sp)
    sw $a0, 8($sp)
    sw $a1, 12($sp)
    sw $t4, 16($sp)
    sw $t7, 20($sp)

    jal ConventionCheck

    lw $ra, 0($sp)
    lw $t0, 4($sp)
    lw $a0, 8($sp)
    lw $a1, 12($sp)
    lw $t4, 16($sp)
    lw $t7, 20($sp)
    addiu $sp, $sp, 24

    addi $t7, $t7, 1        # i++
    addiu $a0, $a0, 4       # arr[i + 1]
    j Loop
OUT:
    # Do not remove this line
    jr      $ra
