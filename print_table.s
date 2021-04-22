@ print_table.s  print_table() takes the array and max array count
@				 and prints out a formatted list of the dice # and
@				 its occurences
@ 4.17.2020
@ Cody McKinney  011160497

@ Define Pi
	.cpu	cortex-a53
	.fpu	neon-fp-armv8
	.syntax	unified

	.data
format:
	.asciz "   Sum of the dice       Number of Occurences"
outpCount:
	.asciz "\t%d\t\t\t"		@ prints out our counter
outpSum:
	.asciz	"%d"		@ prints out our array value at index i
newLine:
	.asciz "\012"		@ prints new line

@ Program Code
	.text
	.align	2
	.global	print_table
	.type	print_table, %function

print_table:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16

	str	r0, [fp, #-16]	@ r0 now holds my array  r0 = sum[]
	str	r1, [fp, #-20]	@ r1 is my array size    r1 = 13
	
	ldr r0, =format
	bl	printf
	ldr	r0, =newLine	@ print new line
	bl	printf
		
	mov	r3, #0		@ r3 = (int i = 0;)
	str	r3, [fp, #-8]	@ store i counter variable on stack [fp, #-8]
	b	compare

loop:
	ldr	r1, [fp, #-8]	@ load i into r1 to print
	ldr	r0, =outpCount	@ load r0 with output statement for i
	bl	printf

	ldr	r3, [fp, #-8]	@ load r3 with counter variable i
	lsl	r3, r3, #2	@ r3 offset by 1
	ldr	r2, [fp, #-16]	@ store r2 with sum[] array
	add	r3, r2, r3	@ offset array

	ldr	r3, [r3]	@ load r3 with address of r3
	mov	r1, r3		@ load r1 with address of r3

	ldr	r0, =outpSum	@ load r0 with output statement for array at index i
	bl	printf

	ldr	r0, =newLine	@ print new line
	bl	printf

	ldr	r3, [fp, #-8]	@ r3 = i
	add	r3, r3, #1	@ i++
	str	r3, [fp, #-8]	@ store i [fp, #-8]

compare:
	ldr	r2, [fp, #-8]	@ load r2 with contents of [fp, #-8] = i
	ldr	r3, [fp, #-20]	@ load r3 with array size   r3 = 13
	cmp	r2, r3		@ compare i with r3	i < 13
	blt	loop

end:
	sub	sp, fp, #4
	pop	{fp, pc}
