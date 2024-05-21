#!/bin/bash

#Program: Rectangle
#Author: Brian Y

#Delete unused files if present
rm *.o
rm *.out
rm *.lis

echo "Assemble perimeter.asm..."
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "Compile rectangle.c using the gcc compiler standard 2011..."
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.c -std=c11

echo "Link the object files using the gcc linker standard 2011..."
gcc -m64 -no-pie -o output.out rectangle.o perimeter.o -std=c11

echo "Run the program 'Rectangle'..."
./output.out

echo "The script file will terminate..."