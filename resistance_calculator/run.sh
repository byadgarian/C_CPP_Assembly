#!/bin/bash

#Program: Resistance Calculator
#Author: Brian Y
#Author E-mail: ***

#Delete unused files if present
rm *.o
rm *.out
rm *.lis

echo "Assemble resistance.asm..."
nasm -f elf64 -l resistance.lis -o resistance.o resistance.asm

echo "Compile electricity.c using the gcc compiler standard 2011..."
gcc -c -Wall -m64 -no-pie -o electricity.o electricity.c -std=c11

echo "Link the object files using the gcc linker standard 2011..."
gcc -m64 -no-pie -o output.out electricity.o resistance.o -std=c11

echo "Run the Ristance Calculator program..."
./output.out

echo "The script file will terminate..."