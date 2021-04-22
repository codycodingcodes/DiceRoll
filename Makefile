rollDice:	main.o init_array.o print_table.o roll_die.o
	rm main.o
	rm init_array.o
	rm print_table.o
	rm roll_die.o
	gcc -c main.s
	gcc -c init_array.s
	gcc -c print_table.s
	gcc -c roll_die.s
	gcc -o rollDice main.o init_array.o print_table.o roll_die.o
	
clean:
	rm *.o rollDice
