@ roll_die.s		roll_die() randomizes and returns a number between 1-6
@ 4.17.2020
@ Cody McKinney 011160497

@ Define Pi
	.cpu	cortex-a53
	.fpu	neon-fp-armv8
	.syntax	unified

@ Program Code
	.text
	.align	2
	.global roll_die
	.type	roll_die, %function

roll_die:
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8

	bl	rand	@ randomize number
	mov	r1, r0	@ random # stored in r1

	mov	r4, #6	@ max amount of dice value

	@ modulo function r1/r4 = r10    r10 = r10 * r4    r10 = r0 - r10
	UDIV	r10, r1, r4
	MUL	r10, r10, r4
	SUB	r10, r0, r10

	mov	r1, r10		@ value found from modulo in r1

	add	r4, r1, #1	@ add r1+1 to make bounds 1-6

	mov	r0, r4		@ move value to r0 for return

	sub	sp, fp, #4
	pop	{fp, pc}
