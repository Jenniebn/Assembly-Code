# Factorial.asm program
#

# Assembly (NON-RECURSIVE) version of:
#   int n, fn=1;
#   cout << "Enter a number:\n";
#   cin >> n;
#   for (int x = 2; x <= n; x++) {
#       fn = fn * x;
#   }
#   cout << "Factorial of " << x << " is:\n" << fn << "\n";
#
.data
	# TODO: Write your initializations here
	enter: .asciiz "Enter a number:\n"
	fact: .asciiz "Factorial of "
	is: .asciiz " is:\n"
	newline: .asciiz "\n"

#Text Area (i.e. instructions)
.text
main:
	# TODO: Write your code here
	li $v0, 4
	la $a0, enter
	syscall 		# prompt to enter number
	li $v0, 5
	syscall 
	move $t0, $v0 	# $t0 = userinput
	li $t1, 1		# $t1 = fn = 1
	li $t2, 0		# $t2 = 0
	li $t3, 2		# $t3 = 2
userinputIs1:
	bne $t0, $t1, loop	# $t0 = 1
	li $v0, 4
	la $a0, fact
	syscall 
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, is
	syscall 
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newline
	syscall 
	j exit
userinputIs0:
	bne $t0, $t2, loop	# $t0 = 0
	li $v0, 4
	la $a0, fact
	syscall 
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, is
	syscall 
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newline
	syscall 
	j exit
userinputIs2:
	bne $t0, $t3, loop	# $t0 = 2
	li $v0, 4
	la $a0, fact
	syscall 
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, is
	syscall 
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, newline
	syscall 
	j exit
loop:
	bgt $t3, $t0, result
	mult $t1, $t3
	mflo $t1
	addi $t3, 1
	j loop
result:
	li $v0, 4
	la $a0, fact
	syscall 
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, is
	syscall 
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newline
	syscall 

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall
