# C Makefile using gcc and gdb
# Roberto Nicolás Savinelli <rsavinelli@frba.utn.edu.ar>

CC = gcc
CFLAGS = -std=c17 -Wall -pedantic-errors
SOURCES = ./*.c

TESTFILE = entrada.txt

OUTPUT = tp1.out

.PHONY: compile debug clean test run

compile:
	$(CC) $(CFLAGS) $(SOURCES) -o $(OUTPUT)

run:
	$(CC) $(CFLAGS) $(SOURCES) -o $(OUTPUT) && ./$(OUTPUT)

test:
	$(CC) $(CFLAGS) $(SOURCES) -o $(OUTPUT) && valgrind -q --tool=memcheck --leak-check=full ./$(OUTPUT) <$(TESTFILE)

debug:
	$(CC) $(CFLAGS) $(SOURCES) -g3 -o $(OUTPUT) && gdb -se $(OUTPUT)

clean:
	$(RM) $(OUTPUT)
