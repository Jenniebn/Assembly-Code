# hello.asm
# A "Hello World" program in MIPS Assembly for CS64
#
#  Data Area - allocate and initialize variables
.data
	enter: .asciiz "Enter an integer:\n"
	hello: .asciiz "Hello Pandemic World of 2021!\n"
	magic1: .asciiz "The magic number is "
	exmark: .asciiz "!!!\n"

#Text Area (i.e. instructions)
.text
main:
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $t1, 13
	mult $t0, $t1
	mflo $t2
	li $v0, 4
	la $a0, hello
	syscall
	li $v0, 4
	la $a0, magic1
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, exmark
	syscall


exit:
	# Exit SPIM: Write your code here!
	li $v0, 10
	syscall
