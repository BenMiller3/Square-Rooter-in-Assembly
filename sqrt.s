sqrt: 			#starts function
move $v0, $a0		#moves value of $a0 to register $v0 - x
li $t0, 0		#loads value 0 to register $t0 - a (lower bound)
li $t1, 0x10000		#loads value of 4096 to $t1 which is the upper bound of 32-bit numbers - m
Loop:			#LOOP STARTS HERE (DO WHILE)
add $t2, $t1, $t0	#adds register $t1 and $t0 (bounds) (m = (a+b))
srl $t3, $t2, 1 	#shifts right logical (reducing the num) m = $t3 (m = a+b >> 1)
mult $t3, $t3 		#loads m*m into temp register $t4 (if m*m <= x) #multu = multiplication of unsigned bits
mflo $t4		#puts the result of mult in $t4
slt $t5, $t4, $v0	#if(m*m < x)
beq $t4, $v0, Next	#Created extra line so that if they are equal it still satisifies the condition (m*m <= x) - the equal part of that statement
beq $t5, $0, Else	#if false, go to ELSE
Next:			#If m*m <=x, continue
move $t0, $t3		#if true: a = m ($t0 (lower bound) = $t3 (m))
j Endif			#Ends the if statement
Else:			#Else statement
move $t1, $t3		#if false: b=m ($t1 (upper bound) = $t3 (m)) 
Endif:			#Jumps here if the if statement is ended
add $t6, $t0, 1		#a+1 in temp var $t6 
bne $t1, $t6, Loop 	#while (a+1) != b, continue to loop
move $v0, $t0		#Ends the program by assigning final value to $v0 for grading
add $v0, $v0, 1		#Adds 1 to final answer (all answers are 1 off)
li $v0, 1		#Next three lines are to print the value to the screen (returning it)
add $a0, $t0, $zero
syscall
jr $ra			#final line

main:
li $a0, 256		#Load 81 as test into $a0
j sqrt			#call sqrt function
