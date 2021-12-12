# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
    li $t0, 0   # $t0 = z = 0
    li $t1, 0   # $t1 = i = 0
forLoop:
    bge $t1, 5, jump
    addi $t1, 1
    add $t2, $a0, $a0   # $t2 = 2*x
    add $t0, $t0, $t2   # $t0 = z + 2*x
    sub $t0, $t0, $a1   # z = z + 2*x - y
if:
    blt $a0, 3, else
    addi $a1, -1
else:
    addi $a0, 1
    j forLoop
jump:
    move $v0, $t0
    jr $ra

main:
	li $a0, 5   # $a0 = 5 = x
    li $a1, 7   # $a1 = 7 = y

    jal conv

	move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
	syscall
