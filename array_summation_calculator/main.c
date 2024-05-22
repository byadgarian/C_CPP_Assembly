//****************************************************************************************************************************
//Program name: High Speed Array Summation                                                                                   *
//This program takes up to 7 floating point numbers from the user and calculates their sum after loading them into an array. *
//Copyright (C) 2021 Brian Y.                                                                                                *                                                                                                                           *
//This file is part of the software program "High Speed Array Summation".                                                    *
//High Speed Array Summation is a free software. You can redistribute it and/or modify it under the terms of the GNU General *
//Public                                                                                                                     *
//License version 3 as published by the Free Software Foundation.                                                            *
//High Speed Array Summation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the   *
//implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more       *
//details.                                                                                                                   *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************

//********** AUTHOR INFORMATION **********************************************************************
//  Author Name: Brian Y
//  Author E-mail: ***

//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: High Speed Array Summation
//  Puropse: This program takes up to 7 floating point numbers from the user and calculates their sum after loading them into an array.
//  Programming Languages: 1 modules in C, 1 module in C++ and 3 module in Assembly X86
//  Date Program Began: 03/10/2021
//  Date of Last Update: 03/22/2021
//  Date of Reorganization of Comments: 03/22/2021
//  Files in this Program: run.sh, main.c, contorl.asm, fill.asm, display.cpp and sum.asm
//  Status: Finished (the program was tested using WSL2 and g, g++ and nasm compilers extensively with no errors)

//********** FILE INFORMATION **********************************************************************
//  File Name: main.c
//  Purpose: main driver
//  Language: C
//  Max Page width: 136 Columns
//  Compile: gcc -g -c -m64 -Wall -no-pie -o main.o main.c -std=c11

//********** MAIN CODE AREA **********************************************************************
#include <stdio.h>

extern double control();    //define external function

int main()
{
    double ret;
    printf("Welcome to High Speed Array Summation by Brian Y.\n");
    printf("Software licensed by GNU GPL 3.0.\n");
    printf("Version 1.0 released on March 22, 2021.\n");
    ret = control();
    printf("The main has received %12.8f and will keep it.\n", ret);
    printf("Thank you for using High Speed Array Summation software.\n");
    printf("For system support contact Brian Y at ***.\n");
    printf("A 0 will be returned to the operating system.\n");
    return 0;
}

//********** END **********************************************************************