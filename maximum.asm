# maximum.asm program
#

.data
	# TODO: Complete these declarations / initializations

	enter: .asciiz "Enter the next number:\n"
	max: .asciiz "Maximum: "
    newline: .asciiz "\n"

#Text Area (i.e. instructions)
.text

main:
	# TODO: Write your code here
    # You can have other labels expressed here, if you need to
	li $v0, 4
	la $a0, enter
	syscall 		# prompt to enter number
	li $v0, 5
	syscall 
	move $t0, $v0 	# user input 1
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 5
	syscall
	move $t1, $v0	# user input 2
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 5
	syscall
	move $t2, $v0	# user input 3
	blt $t0, $t1, elseIf
	blt $t0, $t2, elseIf
	li $v0, 4
	la $a0, max
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	j exit
elseIf: 
	blt $t1, $t2, else
	blt $t1, $t0, else
	li $v0, 4
	la $a0, max
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	j exit
else:
	li $v0, 4
	la $a0, max
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, newline
	syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall
