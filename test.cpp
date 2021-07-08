#include <vector>
#include <fstream>
#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <cmath>
#include <cstdlib>
#include <map>

using namespace std;

int main(int argc, char *argv[]){
    
    map< string , double > extrema ;
    extrema[       "0."] =        0. ;
    extrema[       "1."] =        1. ;
    extrema[    "0./0."] =     0./0. ;
    extrema[    "1./0."] =     1./0. ;
    extrema[  "log(0.)"] =   log(0.) ;
    extrema[ "log(-1.)"] =  log(-1.) ;
    extrema["sqrt(-1.)"] = sqrt(-1.) ;
    
    unsigned int longestString = 1 ;
    
    for( auto test : extrema ){
        if( test.first.length() > longestString )
            longestString = test.first.length() ;
    }
    
    cout << " true=" << true << " \t false=" << false << endl ;
    
    for( auto test : extrema ){
        cout << " " 
             << std::setw(longestString) << test.first 
             << " = " 
             << std::setw(4) << test.second 
             << "\t isnormal : " << std::isnormal(test.second) 
             << " - isfinite : " << std::isfinite(test.second) 
             << " - isnan : "    << std::isnan(test.second) 
             << " - ==0. : "     << (test.second!=0.) 
             << " - ==1. : "     << (test.second!=1.) 
             << " - ==self : "   << (test.second==test.second)
             << " - !=self : "   << (test.second!=test.second) 
             << endl ;
    }
    
    return 0 ;
    
}