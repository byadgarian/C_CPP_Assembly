#!/bin/bash

#Program Name: Virtual Interview
#Author Name: Brian Y
#Author E-mail: ***

#Delete unused files if present
rm *.o
rm *.out

echo "Compile main.cpp using the g++ compiler standard 2017..."
g++ -g -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17

echo "Assemble interview.asm..."
nasm -dwarf -f elf64 -o interview.o interview.asm

echo "Link the object files using the g++ linker standard 2017..."
g++ -g -m64 -fno-pie -no-pie -o output.out -std=c++17 main.o interview.o

echo "Run the program..."
#gdb ./output.out
./output.out

echo "The program will terminate..."