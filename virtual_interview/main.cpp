//********** LICENSE *********************************************************************************************************
//Program Name: Virtual Interview                                                                                            *
//This program takes the name and expected annual salary from an applicant and conducts a virtual interview. The outcome of  *
//the interview is determined based on the applicant's responses to interview questions.                                     *
//Copyright (C) 2021 Brian Y.                                                                                                *                                                                                                                           *
//This file is part of the software program "Virtual Interview".                                                             *
//****************************************************************************************************************************

//********** AUTHOR INFORMATION **********************************************************************
//  Author Name: Brian Y
//  Author E-mail: ***

//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: Virtual Interview
//  Puropse: This program takes the name and expected annual salary from an applicant and conducts a virtual interview.
//           The outcome of the interview is determined based on the applicant's responses to interview questions.
//  Programming Languages: 1 modules in C++ and 1 module in Assembly X86
//  Date Program Began: 05/19/2021
//  Date of Last Update: 05/19/2021
//  Date of Reorganization of Comments: 0g/20/2021
//  Files in this Program: run.sh, main.cpp and interview.asm
//  Status: Finished (the program was tested using WSL2 and g++ and nasm compilers extensively with no errors)

//********** FILE INFORMATION **********************************************************************
//  File Name: main.cpp
//  Purpose: main driver
//  Language: C++
//  Max Page width: 132 Columns
//  Compile: g++ -g -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp -std=c++17

//********** MAIN CODE AREA **********************************************************************
#include <iostream>
#include <iomanip>
#include <string.h>

extern "C" double interview(char *, double);    //define external function

int main()
{
    char name[30];
    double salary;
    double ret;

    std::cout<<"Welcome to Software Analysis by Paramount Programmers, Inc."<<std::endl;
    std::cout<<"Please enter your first and last names and press enter: "<<std::endl;
    std::cin.getline(name, 31);
    name[strlen(name)-1] = '\0';    //remove the line breaks included in the text file (disable this for manual entry)
    std::cout<<"Thank you "<<name;
    std::cout<<". Our records show that you applied for employment here with our agency a week ago."<<std::endl;
    std::cout<<"Please enter your expected annual salary when employed at Paramount: "<<std::endl;
    std::cin>>salary;
    std::cout<<"Your interview with Ms. Linda Fenster, Personnel Manager, will begin shortly."<<std::endl;
    ret = interview(name, salary);
    if (ret == 88000.88)
    {
        std::cout<<"Hello "<<name<<". I am the receptionist."<<std::endl;
        std::cout<<std::fixed;
        std::cout<<"This envelope contains your job offer with starting salary of $"<<std::setprecision(2)<<ret
                 <<". Please check back on Monday morning at 8:00 AM."<<std::endl;
        std::cout<<"Bye."<<std::endl;
    }
    else if (ret == 1000000.00)
    {
        std::cout<<"Hello Mr. "<<name<<". I am the receptionist."<<std::endl;
        std::cout<<std::fixed;
        std::cout<<"This envelope contains your job offer starting at $"<<std::setprecision(2)<<ret
                 <<" annually. Please start any time you like. In the meantime our CTO wishes to have dinner with you."<<std::endl;
        std::cout<<"Have a very nice evening Mr. "<<name<<"."<<std::endl;
    }
    else
    {
        std::cout<<"Hello "<<name<<". I am the receptionist."<<std::endl;
        std::cout<<std::fixed;
        std::cout<<"We have an opening for you in the company cafeteria for $"<<std::setprecision(2)<<ret
                 <<" annually. Take your time to let use know what your decision is."<<std::endl;
        std::cout<<"Bye."<<std::endl;
    }
    return 0;
}

//********** END **********************************************************************