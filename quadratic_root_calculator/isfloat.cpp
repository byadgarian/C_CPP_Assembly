//****************************************************************************************************************************
//Program name: Root Calculator                                                                                              *
//This program will take 3 coefficients of a quadratic equation from the user and calculate it's roots.                      *
//Copyright (C) 2021 Brian Y.                                                                                                *                                                                                                                           *
//This file is part of the software program "Second Degree".                                                                 *
//Root Calculator is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public     *
//License version 3 as published by the Free Software Foundation.                                                            *
//Root Calculator is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied      *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.      *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************

//********** AUTHOR INFORMATION **********************************************************************
//  Author Name: Brian Y
//  Author E-mail: ***

//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: Root Calculator
//  Programming Languages: 3 modules in C++ and 1 module in Assembly X86
//  Date Program Began: 02/20/2021
//  Date of Last Update: 02/28/2021
//  Date of Reorganization of Comments: 02/28/2021
//  Files in this Program: second_degree.cpp, quad_library.cpp, isfloat.cpp and quadratic.asm
//  Status: Finished (the program was tested using WSL2, and g++ and nasm compilers extensively with no errors)

//********** FILE INFORMATION **********************************************************************
//  File Name: isfloat.cpp
//  Language: C++
//  Max Page width: 127 Columns
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

//********** MAIN CODE AREA **********************************************************************
#include <iostream>
#include <cstring>

extern "C" bool isfloat(char s[]);          //declare function for external access - for C++ only

bool isfloat(char s[])
{   
    bool result = true;
    int floatingPointCount = 0;
    int start = 0;
    if (s[0] == '-' || s[0] == '+') start = 1;
    unsigned long int c = start;

    if (s[start] == '.' || s[strlen(s)-1] == '.' || strlen(s) < 3 || strlen(s) > 7)
    {
        return false;
    }
    
    while (!(s[c]=='\0') && result)
    {
        if (s[c] == '.')
        {
            if (floatingPointCount == 0)
            {
                result = true;
            }
            else
            {
                result = false;
            }
            floatingPointCount++;
        }

        if (s[c] != '.')
        {
            result = result && isdigit(s[c]);
        }
        c++;
    }

    if (floatingPointCount == 1)
    {
        return result;
    }

    return false;
}

//********** END **********************************************************************