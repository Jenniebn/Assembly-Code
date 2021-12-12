# swap_array.asm program
#
#
# IMPORTANT: READ, BUT DO NOT CHANGE ANY OF THE CODE IN THIS PROGRAM
#           THAT IS ALREADY THERE! ONLY ADD YOUR NEW CODE WHERE 
#           IT SAYS TO DO SO, i.e. IN THE doSwap: AREA.
#

.data
# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        

incorrect:  .asciiz "---TEST FAILED---\n"
before:     .asciiz "Before:\n"
after:      .asciiz "After:\n"
comma:      .asciiz ", "
newline:    .asciiz "\n"
        
expectedMyArray:
        .word 29 28 27 26 25 24 23 22 21 20 19 17
myArray:
        .word 29 17 27 20 25 22 23 24 21 26 19 28

.text
# Print everything in the array (without use of a loop)
# Used as a function/sub-routine

printArray:
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
		
	li $v0, 1
        lw $a0, 36($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 40($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 44($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
        
# unsigned int* p1 = expectedMyArray
# unsigned int* p2 = myArray
# unsigned int* limit = expectedMyArray + 12
#
# while (p1 < limit) {
#   if (*p1 != *p2) {
#     return 0                  
#   }
#   p1++                        
#   p2++
# }
# return 1                      

checkArrays:
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 44

checkArrays_loop:
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
checkArrays_nonequal:
        li $v0, 0
        jr $ra
        
checkArrays_exit:
        li $v0, 1
        jr $ra
        
main:   
        # Print array "before"
        la $a0, before
        li $v0, 4
        syscall

        jal printArray
        
        # Do swap function 
        jal doSwap

        # Print array "after"
        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        # Perform check on array
        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed:
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
	# TODO: Write code to properly exit a SPIM simulation
        li $v0, 10
	syscall

        
# COPYFROMHERE - DO NOT REMOVE THIS LINE

doSwap:
        # TODO: translate the following C code into MIPS
        # assembly here.
        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.
        #
        #
        # unsigned int x = 1; 
        # unsigned int y = 11; 
        # while (x < 6) { 
        # int temp = myArray[x]; 
        # myArray[x] = myArray[y]; 
        # myArray[y] = temp; 
        # x+=2; 
        # y-=2; 
        # }


        # TODO: fill in the code

        li $t0, 1       # x = 1
        li $t1, 11      # y = 11
while:
        bge $t0, 6, jump
        la $t3, myArray # $t3 = arr
        li $t5, 4       # $t5 = 4
        mult $t5, $t0
        mflo $v0        # $v0 = 4x
        mult $t5, $t1  
        mflo $v1        # $v1 = 4y
        addu $a0, $t3, $v0       # $a0 = arr[x]
        addu $a1, $t3, $v1       # $a1 = arr[y]
        lw $t7, 0($a0)    # $t7 = temp = arr[x]
        lw $t6, 0($a1)    # $t6 = arr[y]
        sw $t6, 0($a0)    # arr[x] = arr[y]
        sw $t7, 0($a1)
        addi $t0, $t0, 2
        addi $t1, $t1, -2
        j while

        # do not remove this last line
jump:   jr $ra


