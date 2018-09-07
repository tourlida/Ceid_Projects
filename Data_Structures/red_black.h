#ifndef RBTREE_H
#define RBTREE_H

// Class to represent Red-Black Tree
enum Color {RED, BLACK};
 
struct Node
{
    int data;
    Color color;
    Node *left, *right, *parent;
 
    // Constructor
    Node(int data)
    {
       this->data = data;
       left = right = parent = NULL;
    }
};



class RBTree
{
private:
    Node *root;
protected:
    void rotateLeft(Node *&, Node *&);
    void rotateRight(Node *&, Node *&);
    void fixViolation(Node *&, Node *&);
public:
    // Constructor
    RBTree() { root = NULL; }
//  void insert(const int &n);
    void display(Node *);
//    void insert();
      void disp();
      void insert(int z);
      void insertfix(Node *);
      void leftrotate(Node *);
      void rightrotate(Node *);
    Node successor(Node *); 
    void search(int x);
  //  void inorder();
    //void levelOrder();
};
  

#endif
