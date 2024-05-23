//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: Harmonic Mean
//  Student Name: Brian Y
//  Student Email: ***

//********** MAIN CODE AREA **********************************************************************
#include <iostream>
#include <iomanip>

extern "C" void display(double *, int);     //define external function

void display(double arr[], int max)
{
    for(int c=0; c<max; c++)
    {
        std::cout<<std::fixed;     //ensures 8 digit precision
        std::cout<<std::setprecision(8)<<arr[c]<<std::endl;
    }
    return;
}

//********** END **********************************************************************