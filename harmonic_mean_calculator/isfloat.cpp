//********** PROGRAM INFORMATION **********************************************************************
//  Program Name: Harmonic Mean
//  Student Name: Brian Y
//  Student Email: ***

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