//****************************************************************************************************************************
//Program name: Rectangle                                                                                                    *
//This program will take the hight and width of a rectangle from the user and calculate the length of average side and the   *
//perimeter. Copyright (C) 2021 Brian Y.                                                                                     *                                                                                                                           *
//This file is part of the software program "Rectangle".                                                                     *
// ***************************************************************************************************************************

//********** AUTHOR INFORMATION **********************************************************************
//  Author Name: Brian Y
//  Author E-mail: ***

//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: Rectangle
//  Programming Languages: One modules in C and one module in Assembly X86
//  Date Program Began: 01/25/2021
//  Date of Last Update: 02/09/2021
//  Date of Reorganization of Comments: 02/09/2021
//  Files in this Program: rectangle.c, perimeter.asm
//  Status: Finished (the program was tested using WSL2 and gcc and nasm compilers extensively with no errors)

//********** FILE INFORMATION **********************************************************************
//  File Name: rectangle.c
//  Language: C
//  Max Page width: 127 Columns
//  Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.c -std=c11
//  Link: gcc -m64 -no-pie -o output.out rectangle.o perimeter.o -std=c11

//********** MAIN CODE AREA **********************************************************************
#include <stdio.h>

extern double perimeter();              //declare function for external access

int main()
{
    double prm = 0.0;
    prm = perimeter();                  //call perimeter function from the .asm file
    printf("The main function received the perimeter %5.3lf.\n", prm);
    printf("A 0 will be returned to the operating system.\n");
    printf("Have a nice day!\n");
    return 0;
}

//********** END **********************************************************************