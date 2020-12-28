#ifndef PROJECT3_HEADER_WEBER_T	
#define PROJECT3_HEADER_WEBER_T

//Function that prompts the user for a text file, reads it, and determines the frequency of each character in the file
void Huff::getFrequencies()
{
	char t;
	int t2;

	string fileName;

	cout << "Enter the name of the text file. " << "\n";
	cin >> fileName;

	message.open(fileName);
	
	// Repeat while the next character is not the terminating character '*'					
	while (message.peek()!='*')			
	{		
		// Read a character from the file
		message >> t;					
		t2 = int(t);

		//If it's a lowercase letter, increment weight for that letter
		if (t2 >= 97 && t2 <= 122)			
		{
			infoArr[t2 - 97].weight++;
			infoArr[t2 - 97].letter = t;
		}

		//If it's an uppercase letter, increment weight for that letter
		else if (t2 >= 65 && t2 <= 90)  
		{
			infoArr[t2 - 65].weight++;
			infoArr[t2 - 65].letter = t;
		}
	}
}

//Helper function to convert an array of characters to a string
string Huff::convertToString(char* a, int size)
{
	int i;
	string s = "";
	for (i = 0; i < size; i++) {
		s = s + a[i];
	}
	return s;
}

//Function that creates a Huffman Tree given a set of characters and their frequencies
void Huff::createHuffTree()
{
	// Create list of nodes with characters and frequencies
	for (int i = 0; i < 26; i++)
	{
		if (infoArr[i].weight)			//weight != 0 means there was at least one occurrence of the character
			funList.push_back(infoArr[i]);				
	}

	// Sort the list by the frequencies of the characters
	funList.sort();						
		
	info* T1, * T2, * T3;
	//Integer with a higher value than the ASCII value than alphabetical characters
	int phil = 161;			

	while (1)
	{
		//Create a new info node equal to the front of the list
		T1 = new info();
		*T1 = funList.front();

		//Pop that item off the list
		funList.pop_front();									

		//Create a new info node equal to the front of the list
		T2 = new info();
		*T2 = funList.front();
		
		//Pop that item off the list
		funList.pop_front();

		//Push a new node onto the list with their combined frequencies and make it the parent node
		T3 = new info(T1->weight + T2->weight,phil, T1, T2);

		//Increment the integer so that each node pushed back has a higher value than the last
		phil++;

		//If the last two items have been popped, assign the last tree's address as the root of the tree
		if (funList.empty())
		{	
			//Assign the last tree's address as the root of the tree
			root = T3;
			//Stop looping
			break;
		}
		
		//Push the new node onto the list (not necessary if it is the final tree)
		funList.push_back(*T3);
		//Sort the list 
		funList.sort();           
	}
}

//Helper function that returns the height of a tree
int Huff::maxDepth(info * node)
{
	if (node == NULL)
		return 0;
	else
	{
		/* compute the depth of each subtree */
		int lDepth = maxDepth(node->llink);								
		int rDepth = maxDepth(node->rlink);

		/* use the larger one */
		if (lDepth > rDepth)
			return(lDepth + 1);
		else return(rDepth + 1);
	}
}

// Postorder traversal of tree that creates the Huffman code for each leaf node and  also copies the node to a corresponding node in an array
void Huff::createCodes(info* boot, char arr[], int top)
{
	// Descending left adds a 0 to the code array
	if (boot->llink) 
	{
		arr[top] = 48;				// 48 is ASCII value of 0
		createCodes(boot->llink, arr, top + 1);
	}

	// Descending left adds a 1 to the code array
	if (boot->rlink) 
	{
		arr[top] = 49;				// 49 is ASCII value of 1
		createCodes(boot->rlink, arr, top + 1);
	}

	// If node is a leaf,
	if (!(boot->llink) && !(boot->rlink)) 
	{
		// Store the code in the node :^]
		boot ->code = convertToString(arr, top);		
		// Also, set the corresponding array node equal to it.
		infoArr[(int(boot->letter)-97)] = *boot;
	}
}

//Function that prompts the user for a text file and writes a table with letters and their Huffman codes to it
void Huff::writeTable()
{
	string fileName;
	ofstream tableFile;
	cout << "Enter the name of the text file to write table to." << "\n";
	cin >> fileName;
	
	tableFile.open(fileName);
	
	//Print the letter and code of each node that has a nonzero weight
	for (int i = 0; i < 26; i++)
	{	
		if (infoArr[i].weight)
			tableFile << infoArr[i].letter << " " << infoArr[i].code << "\n";
	}
	cout << "Table written to "<<fileName<<"\n";
}

//Function that prompts the user for a text file and writes an encoded message to it
void Huff::writeEncoded()
{
	string fileName;
	ofstream encodedFile;

	//Reset file stream
	message.clear();
	message.seekg(0);


	cout << "Enter the name of the file to write encoded message to." << "\n";
	cin >> fileName;

	encodedFile.open(fileName);

	char t;
	int t2;
	while (message.peek() != '*')
	{
		message >> t;
		t2 = int(t);
		if (t2 >= 97 && t2 <= 122)		//If it's an uppercase letter, print that character's code	
			encodedFile << infoArr[t2 - 97].code;
		else if (t2 >= 65 && t2 <= 90)  //If it's an lowercase letter, print that character's cod
			encodedFile << infoArr[t2 - 65].code;
	}
	cout << "Encoded message written to " << fileName << "\n";
}

//Function that prompts the user for a text file containing a Huffman Table and stores its information in an array of nodes
void Huff::readTable()
{
	//CAUTION: THIS OVERWRITES THE CODES PREVIOUSLY STORED IN INFOARR
	string fileName;
	ifstream tableFile;
	cout << "Enter the name of the table file to read" << "\n";
	cin >> fileName;

	tableFile.open(fileName);
	
	char t;
	int t2;
	
	//Read in a character
	tableFile >> t;						
	
	//Repeat while the terminating character has not been read in
	while (t!='*')						
	{
		t2 = int(t);

		//If it's a lowercase letter, store the code that follows in the corresponding array node
		if (t2 >= 97 && t2 <= 122)		
			tableFile >> infoArr[t2 - 97].code;

		//If it's an uppercase letter, store the code that follows in the corresponding array node
		else if (t2 >= 65 && t2 <= 90)  
			tableFile >> infoArr[t2 - 65].code;

		//Read in another character
		tableFile >> t;					
	}
}

//Function that prompts the user for a text file containing an encoded message and prints the decoded message to the screen
void Huff::translateEncoded()
{
	string fileName;
	ifstream encodedFile;
	cout << "Enter the name of the file to decode." << "\n";
	cin >> fileName;

	encodedFile.open(fileName);

	char t;
	int t2;
	string t3;					
	
	//Read in a 0 or 1
	encodedFile >> t;

	//Repeat while the terminating character '*' has not been read in
	while (t!='*')
	{
		//Append the 0 or 1 to the string
		t3 = t3 + t;

		//If the current read code matches the code of a letter from the table, 
		for (int i = 0; i <26; i++)
		{
			if (t3 == infoArr[i].code)
			{
				//Print the letter 
				cout << char(i+65);
				//Reset Code
				t3 = "";
				//Exit loop
				break;
			}	
		}	
		//Read in another 0 or 1
		encodedFile >> t;
	}
}

#include "Project3_Header_Weber.h"
#endif