#!/bin/bash

#Program: Root Calculator
#Author: Brian Y
#Author E-mail: ***

#Delete unused files if present
rm *.o
rm *.out

echo "Assemble quadratic.asm..."
nasm -f elf64 -o quadratic.o quadratic.asm

echo "Compile isfloat.cpp using the g++ compiler standard 2017..."
g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Compile quad_library.cpp using the g++ compiler standard 2017..."
g++ -c -m64 -Wall -fno-pie -no-pie -o quad_library.o quad_library.cpp -std=c++17

echo "Compile second_degree.cpp using the g++ compiler standard 2017..."
g++ -c -m64 -Wall -fno-pie -no-pie -o second_degree.o second_degree.cpp -std=c++17

echo "Link the object files using the g++ linker standard 2017..."
g++ -m64 -fno-pie -no-pie -o output.out -std=c++17 isfloat.o quadratic.o second_degree.o quad_library.o

echo "Run the program..."
./output.out

echo "The program will terminate..."