#ifndef PROJECT3_HEADER_WEBER_H
#define PROJECT3_HEADER_WEBER_H

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <list>

using namespace std;

struct info
{
    char letter;                               
    int weight;
    info* llink, * rlink;
    string code;
   
    bool operator < (const info& n)             //Operator used to compare nodes in List::sort()
    {   
        //If two nodes have the same weight, compare their letters
        if (weight == n.weight)
            return letter < n.letter;
        return weight < n.weight;
    }
    info& operator = (const info& i)            //Operator used to copy the information from one node into another
    {
        letter = i.letter;
        weight = i.weight;
        llink = i.llink;
        rlink = i.rlink;
        code = i.code;

        return *this;
    }
    info()                                      //Default constructor 
    {
        letter = '?';
        weight = 0;
        llink = 0;
        rlink = 0;
    }
    info(int been,char let, info* L, info* R)   //Explicit constructor
    {
        letter = let;
        weight = been;
        llink = L;
        rlink = R;
    }
};
class Huff
{
public:
    info* root = 0;                              // Pointer to the root of Huffman Tree
    list<info> funList;                          // List of nodes used in construction of Huffman Tree
    info infoArr[26];                            // Array to store nodes used throughout program
    ifstream message;                            // Stream to store a text file 

    void getFrequencies();
    void createHuffTree();
    int maxDepth(info* node);
    void createCodes(info * root, char arr[], int top);
    string convertToString(char* a, int size);
    
    void writeEncoded();
    void writeTable();

    void readTable();
    void translateEncoded();
};
#include "Project3_Header_Weber.t"
#endif


