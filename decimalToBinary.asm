.data
	prompt: .asciiz "This program will accept an Integer and Convert into Binary number.\nEnter an Integer: "
	binaryString: .space 9 	#9 Byte. For 1 byte to represent as \0
	binaryFormat: .asciiz "Binary number: 0b"
.text
.globl main
main:
	
	li $t0, 8		# Index for the BinaryString
	
	# Make the last byte of the String as \0 character
	sb $zero, binaryString($t0)
	
	# Prompt User
	jal promptUser
	
	# Get input
	jal getUserInput
	move $t1, $v0	# Move the User Input
	
	li $t0, 0	# Reset the index
	li $t9, 7	# Downward Counter
whileConvert:
	# If index == 7  -> Break
	beq $t0, 8, printString
	
	# Shift Right amount
	srlv $t2, $t1, $t0 
	
	# use AND Operator to get the Result
	andi $t2, $t2, 1
	
	# Convert into String
	addi $t2, $t2, 48
	
	# Add to the binaryString
	sb $t2, binaryString($t9)
	
	# Increase the index
	addi $t0, $t0, 1
	
	# Decrease the Downward Counter
	addi $t9, $t9, -1
	j whileConvert
	
printString:
	jal printBinaryOutput

	# Get the Index
	li $t1, 0

whilePrintString:
	 beq $t1, 8, exitProgram
	 
	 # Get the byte at that index
	 lb $a0, binaryString($t1)
	 li $v0, 11
	 syscall
	 
	 # Increment the Index
	 addi $t1, $t1, 1
	 j whilePrintString

exitProgram:
	li $v0, 10
	syscall

promptUser:
	# Prompt the user
	li $v0, 4
	la $a0, prompt
	syscall
	
	jr $ra

getUserInput:
	# Get User Input
	li $v0, 5
	syscall
	
	move $v0, $v0
	
	jr $ra
	
printBinaryOutput:
	# Print the Format
	li $v0, 4
	la $a0, binaryFormat
	syscall
	
	jr $ra
	
