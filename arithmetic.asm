# arithmetic.asm
# A simple calculator program in MIPS Assembly for CS64
#

.text
main:
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 5
	syscall
	move $t1, $v0
	sub $t3, $t0, $t1
	sll $t3, $t3, 7
	addi $t4, $t3, 32
	move $a0, $t4
	li $v0, 1
	syscall


exit:
	# Exit SPIM: Write your code here!
	li $v0, 10
	syscall
