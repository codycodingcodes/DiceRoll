@ main.s		main() is the driver function and runs the init_array()
@				roll_die() and print_table() methods
@ 4.17.2021
@ Cody McKinney 011160497

@ Define Pi
	.cpu	cortex-a53
	.fpu	neon-fp-armv8
	.syntax unified


@ Program Code
	.text
	.align	2
	.global	main
	.type	main, %function

main:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #64

	mov	r0, #0		@ init r0 for our random #
	bl	time		@ branch to time, store result in r0

	mov	r3, r0		@ store result of time in r3
	mov	r0, r3		@ copy value back to r0
	bl	srand		@ randomize r3 with time seed

	sub	r3, fp, #64	@ r3 = frame pointer - 64  ||| r3 is now pointing at same pos as stack pointer
	mov	r1, #13		@ r1 is array size
	mov	r0, r3		@ r0 is now 1st position of array
	bl	init_array

	mov	r3, #0		@ r3 = i
	str	r3, [fp, #-8]	@ [fp, #-8] now stores i
	b	loop

for:
	bl	roll_die	@ run roll_die() function
	str	r0, [fp, #-12]	@ store result of our first dice roll [fp, #-12]

	bl	roll_die	@ roll_die() 2nd result
	mov	r2, r0		@ store 2nd dice roll in r2
	ldr	r3, [fp, #-12]	@ store r3 with our first dice roll value

	add	r3, r3, r2		@ add both dice rolls for our total
	str	r3, [fp, #-12]	@ store Total Dice Roll (in r3) store on stack [fp, #-12]
	ldr	r3, [fp, #-12]	@ load r3 with our total dice dice roll
	lsl	r3, r3, #2		@ offset r3 r3 is our total
	
	sub	r2, fp, #4		@ increasing occurence of rolling r3 value
	add	r3, r2, r3		@ r3 is temp_sum
	ldr	r3, [r3, #-60]	@ load r3 with address of temp_value
	add	r2, r3, #1		@ increment occurences of r3/temp value r2 is occurences
	ldr	r3, [fp, #-12]	@ load r3 with our total dice roll/ array index
	lsl	r3, r3, #2		@ offset r3

	sub	r1, fp, #4
	add	r3, r1, r3		@ new offset

	str	r2, [r3, #-60]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1		@ increment i counter (i++)
	str	r3, [fp, #-8]	@ store new i value in [fp, #-8]

loop:
	ldr	r3, [fp, #-8]	@ r3 = i
	cmp	r3, #1000		@ r3 < 1000	i < 1000
	blt	for				@ if i < 1000 branch to for loop

	sub	r3, fp, #64		@ 1st position of sum array
	mov	r1, #13			@ array size, to pass to print
	mov	r0, r3			@ sum array in r0, to pass to print
	bl	print_table
	
	
end:
	mov	r3, #0
	mov	r0, r3

	sub	sp, fp, #4
	pop	{fp, pc}
