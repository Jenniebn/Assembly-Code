# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array are:\n"

.text
printA:
    # TODO: Write your function code here
	li $t0, 0					# $t0 = i = 0
forLoop:	
	bge $t0, $a1, jump			# $a0 = arr, $a1 = 10 = al

	lw $t1, 0($a0)				# $t1 = arr[i]
	move $t5, $a0
	li $v0, 1
	move $a0, $t1
	syscall
	move $a0, $t5
	addiu $a0, $a0, 4
	addi $t0, $t0, 1
	j forLoop
jump:
	jr $ra

main:
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array	# $a0 = arr
	li $a1, 10		# $a1 = 10 = al

	jal printA

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall

