#include <iomanip>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>
#include <iterator>
#include <stdlib.h>     /* atoi */
#include "red_black.h"
#include "MyFunc.h"
#include <bits/stdc++.h>
using namespace std ;

int main(){

	// Driver Code
	ifstream fin;
	//vector<int> myVector;
	int size;
	int ans;
	int searching_num;
	RBTree tree;

cout<<"1.Reading a file with integers\n2.Reading a file with words\n";
cin>>ans;
while(ans<1 || ans>2)
{
cout<<"Wrong choice!\nPlease enter a choice between 1-2\n";
cin>>ans;
}



if(ans==1)
{
	vector<int> myVector;
	fin.open("new_integers.txt");
	
	if(!fin.is_open() ) 
	{
		cout<<"Error: File Open" << '\n';
	}else  if (fin.is_open()){
		LoadData(fin,myVector);
		size=myVector.size();
	}

	cout<<"1.Enter a number for searching:\n2.Create a red black tree\n3.Testing Times of each search\n";
	cin>>ans;

	while(ans<1 || ans>3)
	{
		cout<<"This choice doesn't exist\nPlease try again!\nPlease enter a choice between 1-3\n";
		cin>>ans;
	}
	for (int i = 0; i < myVector.size(); i++)
	{    
		tree.insert(myVector[i]);
	}



       switch(ans)
       {
       case 1:
              mergeSort(myVector, 0,size);
              printf("\b\nSorted Array\n");
              printVector(myVector,size);
              cout << "Enter the number you want to find:"<<endl;
              cin >> searching_num;
              cout<<"Please choose the method of searching that you want to use"<<endl;
              cout<<"\b1.Linear search\n2.binary search\n3.interpolation search\n";
              cout<<"Please enter a choice between 1-3\n";

              cin>>ans;
              while(ans<1 || ans>3)
              {
              cout<<"This choice doesn't exist\nPlease try again!\nPlease enter a choice between 1-3\n";
              cin>>ans;
              }

              switch(ans){
              case 1:
                     linear_search(myVector,searching_num);
              break;
              case 2:
                     binary_search(myVector,searching_num);
              break;
              case 3:
                     interpolation_search(myVector,searching_num);
              break;
                  }
     break;
     case 2:
              do
               {
                cout<<"\n\t RED BLACK TREE " ;
                cout<<"\n 1. Insert in the tree ";
                cout<<"\n 2. Search for an element in the tree";
                cout<<"\n 3. Display the tree ";
                cout<<"\n 4. Exit " ;
                cout<<"\nEnter Your Choice: ";
                cin>>ch;
                switch(ch)
                {
                          case 1 :
                                  cout<<"\nEnter key of the node to be inserted: ";
                                  cin>>x;
                                   tree.insert(x);
                                   cout<<"\nNode Inserted.\n";
                                   break;
                          case 2 :
                                  cout<<"\n Enter key of the node to be searched: ";
                                  cin>>x;
                                  tree.search(x);
                                   break;
                          case 3 : tree.disp();
                                   break;
                          case 4: y=1;
                                  break;
                          default : cout<<"\nEnter a Valid Choice.";
                }
                cout<<endl;

            }while(y!=1);
	break;
	
	case 3:
	            TEST(myVector,tree);

			break;
	}
}
	else 
	{
		 string word;
		 int y,i,ch;
		 vector<string>  myVector;

		fin.open("new_words.txt");
		if(!fin.is_open() ) 
		{
		 cout<<"Error: File Open" << '\n';
		}else  if (fin.is_open()){ 
		 LoadDataTrie(fin,myVector);
		 size=myVector.size();
		
	    
	 
		// Construct trie
		trie_t trie;
		initialize(&trie);
		for ( i = 0; i <size; i++)
		insertTrie(&trie, myVector[i]);

              do
              {
                cout<<"\n\t TRIE TREE " ;
                cout<<"\n 1. Insert in the tree ";
                cout<<"\n 2. Search for an element in the tree";
                cout<<"\n 3. Delete from the tree ";
                cout<<"\n 4. Exit " ;
                cout<<"\nEnter Your Choice: ";
                cin>>ch;
                switch(ch)
                {
                          case 1 : cout<<"Please enter the word that you wanna add\n";
                                   cin>>word;
                                   insertTrie(&trie,word);
                                   cout<<"\nword Inserted.\n";
                                   break;
                          case 2 : 
                                  cout<<"Please enter a word that you want to search:\n";
                                  cin>>word;
                                  // Search for different keys
                                  if(searchTrie(&trie, word)==0){ 
                                  cout<<"The word "<<word<<" doesnt present to the file\n";   
                                  }else
                                  {
                                  cout<<"The word "<<word<<" is presented to the file\n";   
                                  }
                                  break;
                          case 3 :
                                  cout<<"Please enter a word that you want to delete\n";
                                  cin>>word;
                                  deleteKey(&trie,word);
                                   break;
                          case 4: y=1;
                                  break;
                          default : cout<<"\nEnter a Valid Choice.";
                      }

               cout<<endl;

       }while(y!=1);
}
}
   return 0;
}

