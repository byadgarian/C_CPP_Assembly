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
//  File Name: quad_library.cpp
//  Language: C++
//  Max Page width: 127 Columns
//  Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o quad_library.o quad_library.cpp -std=c++17

//********** MAIN CODE AREA **********************************************************************
#include <iostream>

//declare function for external access - for C++ only
extern "C" void showNoRoots();
extern "C" void showOneRoot(double);
extern "C" void showTwoRoots(double, double);

void showNoRoots()
{
    std::cout<<"This equation has no roots."<<std::endl;
}

void showOneRoot(double root)
{
    std::cout.precision(6);         //display 6 digits after the decimal point
    std::cout<<"The root is "<<root<<std::endl;
}

void showTwoRoots(double root1, double root2)
{
    std::cout.precision(6);         //display 6 digits after the decimal point
    std::cout<<"The roots are "<<root1<<" and "<<root2<<std::endl;
}

//********** END **********************************************************************