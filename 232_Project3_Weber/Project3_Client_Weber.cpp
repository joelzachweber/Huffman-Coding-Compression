#include "Project3_Header_Weber.h"

using namespace std;

int main()
{
	Huff Puff;
	int choice;
	bool done;
	char* depth;

	while (1)
	{
		cout << "Enter the number of your selection and press enter.\n\n"
			<< "     1. Encode or create a table for a message\n"
			<< "     2. Translate an encoded message using a table\n"
			<< "     3. End program\n";

		cin >> choice;
		switch (choice)
		{
		case (1):	
			done = false;
			//Get character frequencies from a text file
			Puff.getFrequencies();
			//Create a Huffman Tree from those frequencies
			Puff.createHuffTree();
			//Dynamically allocate an array to store Huffman code with max size == height of tree
			depth = new char[Puff.maxDepth(Puff.root)];
			//Generate the Huffman Codes for the characters in the file
			Puff.createCodes(Puff.root, depth, 0);
			//Deallocate the array
			delete[] depth;

			cout << "Codes created.\n";
			while (!done)
			{
				cout << "Select action:\n"
					<< "     1. Write encoded message to file\n"
					<< "     2. Write table to file\n"
					<< "     3. Create codes for a new file\n"
					<< "     4. Previous menu\n";
				cin >> choice;
				switch (choice)
				{
				case (1)://Write an encoded version of the original file to another text file
					Puff.writeEncoded();
					break;
				case (2)://Write a table with the Huffman codes for each character in the original file to another text file
					Puff.writeTable();
					break;
				case (3)://Generate Huffman Tree/Codes for a different text file
					Puff.getFrequencies();
					depth = new char[Puff.maxDepth(Puff.root)];
					Puff.createCodes(Puff.root, depth, 0);
					delete [] depth;
					Puff.createHuffTree();
					cout << "Codes created.\n";
					break;
				case (4)://Exit submenu
					done = true;
				}
			}
			break;

		case (2):
			//Store information from a Huffman Table
			Puff.readTable();
			//Translate an encoded message
			Puff.translateEncoded();
			break;

		case (3):
			//End program
			return 0;
		}
	}
	return 0;
}

//Decode a message using a table
	//Read in table
	//
//Create codes for a message
	//Write a table to a file
	//Write an encoded message to a file
//






// In general, is it bad to have lots of data members in your classes? Is it better to always pass data through 
// functions and keep it "separate?"

// Create a new "Huff" each time a new file is introduced?
	//Give each Huff several class member streams?
	// tableInfile = getFile();

// Delete tree after codes created?

//CONVENTIONS:
	//smaller on left
	// if alpha chars frequency is the same, use lexicographical ordering to determine smaller
	// if alpha and a Tree still smaller on left
	// if alpha and Tree have same frequency, alpha on left					
	// if both Trees have same frequency, lower numbered Tree on the left

//HUFFMAN TREE CONSTRUCTED. TIME TO PRINT THOSE CODES BITCH.
		//PRINT TO CONSOLE.
		//Store Huffman code to each node?
		//Store Huffman code in an array?
		//At each leaf, push info into an array
		//		Array of infos?			
		//			if (isLeaf)
		//				newArr[int(root->letter)] = * root		copy constructor?
		//			assignment operator overload for info
		//			how is that array populated? in terms of constructor
		//		Array of strings?

	//ASK FOR FILE NAME FOR TABLE.

	//WRITE TABLE TO FILE. SYMBOL / FREQUENCY / HUFFMAN CODE
		//Go through array. If frequency is not 0 print it.
		//Create Array of Infos by traversing tree?
		//Traverse tree and push nodes onto another list and sort? (for if you want to sort by frequency)

		//At each leaf: save code to node and push node onto another list


	//ASK FOR FILE NAME FOR ENCODED MESSAGE.

	//WRITE ENCODED MESSAGE TO FILE.
		// 1. Read through original file again, one char at a time. Print the code of the current char.
		// 2. Read original file into a string. iterate through the chars, printing the code of each.
		// 3. Read through original file again, one char at a time. Search through copy of original 
		//	  linked list and print the 

	//ASK FOR FILES OF TABLE AND CODE.

	//READ TABLE
		// 1. Save Huffman Code for each symbol (array?)
		// 2. Build tree using table?
	//READ CODE
		// 1. Append to a string and compare to table at each step. If a match write that symbol and reset string.
		// 2. Start at root and descend left/right based on 0/1. 