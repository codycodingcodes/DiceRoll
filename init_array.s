@ init_array.s		init_array() takes the array and max array value
@					and initializes all elements of the array as 0
@ 4.17.2021
@ Cody McKinney 011160497

@ Define Pi
	.cpu	cortex-a53
	.fpu	neon-fp-armv8
	.syntax unified

@ Program Code
	.text
	.align	2
	.global	init_array
	.type	init_array, %function

init_array:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #20

	str	r0, [fp, #-16]	@ storing my array on [fp, #-16]
	str	r1, [fp, #-20]	@ storing my array count on [fp, #-20]
	mov	r3, #0		@ r3 is my counter variable (int i = 0;)
	str	r3, [fp, #-8]	@ store i on stack at [fp, #-8]
	b	compare2

for2:
	ldr	r3, [fp, #-8]	@ store in r3 my counter variable i
	lsl	r3, r3, #2	@ offset for counter
	ldr	r2, [fp, #-16]	@ store my array in r2

	add	r3, r2, r3	@ offset array position
	mov	r2, #0		@ r2 is my zero value to initialize all elements of the array to 0
	str	r2, [r3]	@ store the #0 (r2) in my array at the offset position
	ldr	r3, [fp, #-8]	@ store i counter variable in r3
	add	r3, r3, #1	@ increment i (i++)
	str	r3, [fp, #-8]	@ store i counter back on stack [fp, #-8]

compare2:
	ldr	r2, [fp, #-8]	@ store in r2 my i counter variable
	ldr	r3, [fp, #-20]	@ store my max array count in r1
	cmp	r2, r3		@ compare r2 with r3
	blt	for2		@ if r2 < r3     i < 13

end:
	sub	sp, fp, #4
	pop	{fp, pc}
