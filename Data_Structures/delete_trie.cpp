#include <stdio.h>
#include <iomanip>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>
#include <iterator>
#include <stdlib.h>  
#include <bits/stdc++.h> 
// Alphabet size (# of symbols)
 
#define ALPHABET_SIZE (52)
#define INDEX(c) ((int)c - (int)'a')
 
#define FREE(p) \
    free(p);    \
    p = NULL;
 
using namespace std; 

// forward declration
typedef struct trie_node trie_node_t;
 
// trie node
struct trie_node
{
    int value; // non zero if leaf
    trie_node_t *children[ALPHABET_SIZE];
};
 
// trie ADT
typedef struct trie trie_t;
 
struct trie
{
    trie_node_t *root;
    int count;
};
 
trie_node_t *getNode(void)
{
    trie_node_t *pNode = NULL;
 
    pNode = (trie_node_t *)malloc(sizeof(trie_node_t));
 
    if( pNode )
    {
        int i;
 
        pNode->value   = 0;
 
        for(i = 0; i < ALPHABET_SIZE; i++)
        {
            pNode->children[i] = NULL;
        }
    }
 
    return pNode;
}
 
void initialize(trie_t *pTrie)
{
    pTrie->root = getNode();
    pTrie->count = 0;
}
 
void insert(trie_t *pTrie, string key)
{
    int level;
    
    int index;
    trie_node_t *pCrawl;
 
    pTrie->count++;
    pCrawl = pTrie->root;
 
    for( level = 0; level < key.size(); level++ )
    {
        index = INDEX(key[level]);
 
        if( pCrawl->children[index] )
        {
            // Skip current node
            pCrawl = pCrawl->children[index];
        }
        else
        {
            // Add new node
            pCrawl->children[index] = getNode();
            pCrawl = pCrawl->children[index];
        }
    }
 
    // mark last node as leaf (non zero)
    pCrawl->value = pTrie->count;
}
 
int search(trie_t *pTrie, string key)
{
    int level;
    int index;
    trie_node_t *pCrawl;
 
    pCrawl = pTrie->root;
 
    for( level = 0; level < key.size(); level++ )
    {
        index = INDEX(key[level]);
 
        if( !pCrawl->children[index] )
        {
            return 0;
        }
 
        pCrawl = pCrawl->children[index];
    }
 
    return (0 != pCrawl && pCrawl->value);
}
 
int leafNode(trie_node_t *pNode)
{
    return (pNode->value != 0);
}
 
int isItFreeNode(trie_node_t *pNode)
{
    int i;
    for(i = 0; i < ALPHABET_SIZE; i++)
    {
        if( pNode->children[i] )
            return 0;
    }
 
    return 1;
}
 
bool deleteHelper(trie_node_t *pNode, string key, int level, int len)
{
    if( pNode )
    {
        // Base case
        if( level == len )
        {
            if( pNode->value )
            {
                // Unmark leaf node
                pNode->value = 0;
 
                // If empty, node to be deleted
                if( isItFreeNode(pNode) )
                {
                    return true;
                }
 
                return false;
            }
        }
        else // Recursive case
        {
            int index = INDEX(key[level]);
 
            if( deleteHelper(pNode->children[index], key, level+1, len) )
            {
                // last node marked, delete it
                FREE(pNode->children[index]);
 
                // recursively climb up, and delete eligible nodes
                return ( !leafNode(pNode) && isItFreeNode(pNode) );
            }
        }
    }
 
    return false;
}
 
void deleteKey(trie_t *pTrie, string key)
{
   //int len = key.size();
 
    if( key.size() > 0 )
    {
        deleteHelper(pTrie->root, key, 0, key.size());
    }
}

void LoadDataTrie(ifstream &file,vector<string> &v)
{
int j=0;
string data;

while(file>>data)
{
v.push_back(data);
j++;
}
file.close();
int sz=v.size();
cout<<"\bfile has been loaded\n";
cout<<"\b\nInitial array :\n";
    
    for (int i=0; i < sz; i++)
        cout<<"\b"<<v[i]<<"\n";

}


 
int main()
{

   ifstream fin;
   vector<string>  myVector;
   string word;
    int size;
   int ans;
   int searching_num;
   int y,ch,i;
   fin.open("words.txt");
   if(!fin.is_open() ) 
   {
    cout<<"Error: File Open" << '\n';

   }else  if (fin.is_open()){

   LoadDataTrie(fin,myVector);
   size=myVector.size();
  }
    
 
     // Construct trie
    
    trie_t trie;
 
    initialize(&trie);
    for ( i = 0; i <size; i++)
      insert(&trie, myVector[i]);

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
                                   insert(&trie,word);
                                   //SaveData(myVector);
                                   cout<<"\nword Inserted.\n";
                                   break;
                          case 2 : 
                                  cout<<"Please enter a word that you want to search:\n";
                                  cin>>word;
                                  // Search for different keys
                                  if(search(&trie, word)==0){ 
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


 
   // deleteKey(&trie, "vagia");
 
    //printf("%s %s\n", "vagia", search(&trie, "vagia") ? "Present in trie" : "Not present in trie");





 
    return 0;
}
