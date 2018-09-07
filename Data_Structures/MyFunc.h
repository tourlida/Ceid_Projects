#ifndef MYFUNC_H_INCLUDED
#define MYFUNC_H_INCLUEDE
#include <iomanip>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>
#include <iterator>
#include <stdlib.h>     /* atoi */
#include "red_black.h"
#include <bits/stdc++.h>
// Alphabet size (# of symbols)
#define ALPHABET_SIZE (52)
#define INDEX(c) ((int)c - (int)'a')
#define FREE(p) \
    free(p);    \
    p = NULL;
using namespace std ;


void merge(vector<int> &v, int l, int m, int r);
void mergeSort(vector<int> &v, int l, int r);
void printVector(vector<int> &v, int size);
void LoadData(ifstream &file,vector<int> &v);
void linear_search(vector<int> &v,int searching_num);
void binary_search(vector<int> &v,int searching_num);
void interpolation_search(vector<int> &v,int searching_num);
void TEST(vector<int> &v,RBTree tree);
//RBTree tree;
// Merges two subarrays of arr[].
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
void merge(vector<int> &v, int l, int m, int r)
{
	int i, j, k;
	int n1 = m - l + 1;
	int n2 =  r - m;

	/* create temp arrays */
	int L[n1], R[n2];

	/* Copy data to temp arrays L[] and R[] */
	for (i = 0; i < n1; i++)
	L[i] = v[l + i];
	for (j = 0; j < n2; j++)
	R[j] = v[m + 1+ j];

	/* Merge the temp arrays back into arr[l..r]*/
	i = 0; // Initial index of first subarray
	j = 0; // Initial index of second subarray
	k = l; // Initial index of merged subarray
	while (i < n1 && j < n2)
	{
	if (L[i] <= R[j])
	{
	    v[k] = L[i];
	    i++;
	}
	else
	{
	    v[k] = R[j];
	    j++;
	}
	k++;
	}
	/* Copy the remaining elements of L[], if there
	are any */
	while (i < n1)
	{
	v[k] = L[i];
	i++;
	k++;
	}

	/* Copy the remaining elements of R[], if there
	are any */
	while (j < n2)
	{
	v[k] = R[j];
	j++;
	k++;
	}
	}

	/* l is for left index and r is right index of the  sub-array of arr to be sorted */
	void mergeSort(vector<int> &v, int l, int r)
	{
	if (l < r)
	{
	// Same as (l+r)/2, but avoids overflow for
	// large l and h
	int m = l+(r-l)/2;
	// Sort first and second halves
	mergeSort(v, l, m);
	mergeSort(v, m+1, r);

	merge(v, l, m, r);
	}
}


/* Function to print an vector */
void printVector(vector<int> &v, int size)
{
	int i;
	for (i=1; i <= size; i++)
	printf("\b%d\n", v[i]);
	printf("\n");             
}


void LoadData(ifstream &file,vector<int> &v)
{
	int j=0;
	long int data;

	while(file>>data){
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

void linear_search(vector<int> &v,int searching_num)
{
	int pos,flag=0;
	for(int i=0;i<v.size();i++)
	{
	  if(searching_num==v[i]){
	  flag=1;
	  pos=i;
	  }
	}
	if(flag==1)
	{
	cout<<"the "<<searching_num<<" is found at the location "<<pos<<endl;
	}else
	{
	cout<<"The searching number "<<searching_num<<" does not contained in our file!\n"<<endl;
	}

}


void binary_search(vector<int> &v,int searching_num)
{
	int first=0;
	int last=v.size();
	int middle=(first+last)/2;
	
	while(first<=last)
	{
	if(v[middle]<searching_num)
	{
	first=middle+1;
	}else if(v[middle]==searching_num){

	cout<<"search is found at the location "<<middle+1<<"\n";
	break;
	}else 
	{
	last=middle-1;
	}
	middle=(first+last)/2;
	}
	if(first>last)
	{
	cout<<"The searching number "<<searching_num<<" does not contained in our file!"<<endl;

	}

	}

	void interpolation_search(vector<int> &v,int searching_num)
	{
	int low=0;
	int high=v.size();
	int flag=0;
	while(low<=high && searching_num>=v[low] && searching_num<=v[high])
	{
	int pos=low+ (((double)(high-low) / (v[high]-v[low]))*(searching_num-v[low]));
	if(v[pos]==searching_num) {cout<<"search is found at the location "<<pos<<endl;flag=1;}
	if(v[pos]<searching_num) {
	low=pos+1;
	}else{
	high=pos-1;
	}
	}
	if(flag==0){cout<<"The searching number "<<searching_num<<" does not contained in our file!"<<endl;}

}



void RBTree::insert(int z)
{
	int i=0;
	Node *p,*q;
	Node *t=new Node(z);
	//t->data=z;
	t->left=NULL;
	t->right=NULL;
	t->color=RED;
	p=root;
	q=NULL;
	if(root==NULL)
	{
	   root=t;
	   t->parent=NULL;
	}
	else
	{
	 while(p!=NULL)
	 {
	      q=p;
	      if(p->data < t->data)
		  p=p->right;
	      else
		  p=p->left;
	 }
	 t->parent=q;
	 if(q->data < t->data)
	      q->right=t;
	 else
	      q->left=t;
	}
	insertfix(t);
}
void RBTree::insertfix(Node *t)
{
     Node *u;
     if(root==t)
     {
         t->color=BLACK;
         return;
     }
     while(t->parent!=NULL&&t->parent->color==RED)
     {
           Node *g=t->parent->parent;
           if(g->left==t->parent)
           {
                        if(g->right!=NULL)
                        {
                              u=g->right;
                              if(u->color==RED)
                              {
                                   t->parent->color=BLACK;
                                   u->color=BLACK;
                                   g->color=RED;
                                   t=g;
                              }
                        }
                        else
                        {
                            if(t->parent->right==t)
                            {
                                 t=t->parent;
                                 leftrotate(t);
                            }
                            t->parent->color=BLACK;
                            g->color=RED;
                            rightrotate(g);
                        }
           }
           else
           {
                        if(g->left!=NULL)
                        {
                             u=g->left;
                             if(u->color==RED)
                             {
                                  t->parent->color=BLACK;
                                  u->color=BLACK;
                                  g->color=RED;
                                  t=g;
                             }
                        }
                        else
                        {
                            if(t->parent->left==t)
                            {
                                   t=t->parent;
                                   rightrotate(t);
                            }
                            t->parent->color=BLACK;
                            g->color=RED;
                            leftrotate(g);
                        }
           }
           root->color=BLACK;
     }
}



void RBTree::leftrotate(Node *p)
{
     if(p->right==NULL)
           return ;
     else
     {
           Node *y=p->right;
           if(y->left!=NULL)
           {
                  p->right=y->left;
                  y->left->parent=p;
           }
           else
                  p->right=NULL;
           if(p->parent!=NULL)
                y->parent=p->parent;
           if(p->parent==NULL)
                root=y;
           else
           {
               if(p==p->parent->left)
                       p->parent->left=y;
               else
                       p->parent->right=y;
           }
           y->left=p;
           p->parent=y;
     }
}
void RBTree::rightrotate(Node *p)
{
     if(p->left==NULL)
          return ;
     else
     {
         Node *y=p->left;
         if(y->right!=NULL)
         {
                  p->left=y->right;
                  y->right->parent=p;
         }
         else
                 p->left=NULL;
         if(p->parent!=NULL)
                 y->parent=p->parent;
         if(p->parent==NULL)
               root=y;
         else
         {
             if(p==p->parent->left)
                   p->parent->left=y;
             else
                   p->parent->right=y;
         }
         y->right=p;
         p->parent=y;
     }
}

void RBTree::disp()
{
     display(root);
}

void RBTree::display(Node *p)
{
     if(root==NULL)
     {
          cout<<"\nEmpty Tree.";
          return ;
     }
     if(p!=NULL)
     {
                cout<<"\n\t NODE: ";
                cout<<"\n Key: "<<p->data;
                cout<<"\n Colour: ";
    if(p->color==BLACK)
     cout<<"Black";
    else
     cout<<"Red";
                if(p->parent!=NULL)
                       cout<<"\n Parent: "<<p->parent->data;
                else
                       cout<<"\n There is no parent of the node.  ";
                if(p->right!=NULL)
                       cout<<"\n Right Child: "<<p->right->data;
                else
                       cout<<"\n There is no right child of the node.  ";
                if(p->left!=NULL)
                       cout<<"\n Left Child: "<<p->left->data;
                else
                       cout<<"\n There is no left child of the node.  ";
                cout<<endl;
    if(p->left)
    {
                 cout<<"\n\nLeft:\n";
     display(p->left);
    }
    /*else
     cout<<"\nNo Left Child.\n";*/
    if(p->right)
    {
     cout<<"\n\nRight:\n";
                 display(p->right);
    }
    /*else
     cout<<"\nNo Right Child.\n"*/
     }
}
void RBTree::search(int x)
{
     if(root==NULL)
     {
           cout<<"\nEmpty Tree\n" ;
           return  ;
     }
    
     Node *p=root;
     int found=0;
     while(p!=NULL&& found==0)
     {
            if(p->data==x)
                found=1;
            if(found==0)
            {
                 if(p->data <x)
                      p=p->right;
                 else
                      p=p->left;
            }
     }
     if(found==0)
          cout<<"\nElement Not Found.";
     else
     {
                cout<<"\n\t FOUND NODE: ";
                cout<<"\n Key: " << p->data;
                cout<<"\n Colour: ";
    if(p->color==BLACK)
     cout<<"Black";
    else
     cout<<"Red";
                if(p->parent!=NULL)
                       cout<<"\n Parent: "<<p->parent->data;
                else
                       cout<<"\n There is no parent of the node.  ";
                if(p->right!=NULL)
                       cout<<"\n Right Child: "<<p->right->data;
                else
                       cout<<"\n There is no right child of the node.  ";
                if(p->left!=NULL)
                       cout<<"\n Left Child: "<<p->left->data;
                else
                       cout<<"\n There is no left child of the node.  ";
                cout<<endl;

     }
}

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
 
void insertTrie(trie_t *pTrie, string key)
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
 
int searchTrie(trie_t *pTrie, string key)
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




void TEST(vector<int> &v,RBTree tree)
{ 
		double duration[10];
                int rnd;
                int choice;
                srand((unsigned int)time(0));

                cout << "Press 1 for Linear Search Time " << endl;
                cout << "Press 2 for Binary Search Time " << endl;
                cout << "Press 3 for Interpolation Search Time" << endl;
                cout << "Press 4 for Red Black Search Time " << endl;

                 cin>>choice;
                while(choice<1 || choice>4)
                {
                 cout<<"Wrong choice!\nPlease try again!\n";cout << "Press 1 for Linear Search Time " << endl;
                cout << "Press 2 for Binary Search Time " << endl;
                cout << "Press 3 for Interpolation Search Time" << endl;
                cout << "Press 4 for Red Black Search Time " << endl;

                 cin>>choice;
                }
                 
for(int j=1;j<10;j++)
{
                clock_t StartTime = clock();

                switch (choice)
                {
                case 1:
                {
                                  for (int i = 0; i < 2000; i++)
                                  {


                                          rnd = rand() % 13000;


                                        linear_search(v,rnd);

                                  }
                                  break;
                }
                case 2:
                {
                                  for (int i = 0; i < 2000; i++)
                                  {
                                          rnd = rand() % 13000;

                                          binary_search(v, rnd);

                                  }
                                  break;
                }
                case 3:
                {
                                  for (int i = 0; i < 2000; i++)
                                  {


                                         rnd = rand() % 13000;

                                          interpolation_search(v, rnd);
                                  }
                                  break;
                }
                case 4:
                {
                                  for (int i = 0; i < 2000; i++)
                                  {




                                          rnd = rand() % 13000;


                                           tree.search(rnd);

                                   }
                                  break;
                }
                default:
                {
                                   cout << "Wrong choice" << endl;
                }

                }

                clock_t EndTime = clock();

                 duration[j] = (EndTime - StartTime) / (double)CLOCKS_PER_SEC;
}

	for (int i=1;i<10;i++)
	{

	                cout << "DURATION : " << duration[i] << endl;
	}
        }


#endif

