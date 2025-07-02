%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char* s);

// Structure for syntax tree node
typedef struct Node {
    char* value;
    struct Node* left;
    struct Node* right;
} Node;

Node* createNode(const char* value, Node* left, Node* right);
void printTree(Node* node, int level);
%}

%union {
    char* str;
    struct Node* node;
}

%token <str> ID
%type <node> stmt expr

%left '+' '-'
%left '*' '/'

%%

stmt : ID '=' expr ';' {
          Node* assignNode = createNode("=", createNode($1, NULL, NULL), $3);
          printf("\nSyntax Tree:\n");
          printTree(assignNode, 0);
          free($1);
      }
     ;

expr : expr '+' expr {
          $$ = createNode("+", $1, $3);
      }
     | expr '-' expr {
          $$ = createNode("-", $1, $3);
      }
     | expr '*' expr {
          $$ = createNode("*", $1, $3);
      }
     | expr '/' expr {
          $$ = createNode("/", $1, $3);
      }
     | ID {
          $$ = createNode($1, NULL, NULL);
          free($1);
      }
     ;

%%

Node* createNode(const char* value, Node* left, Node* right) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->value = strdup(value);
    newNode->left = left;
    newNode->right = right;
    return newNode;
}

void printTree(Node* node, int level) {
    if (node == NULL) return;
    printTree(node->right, level + 1);
    for (int i = 0; i < level; i++) printf("    ");
    printf("%s\n", node->value);
    printTree(node->left, level + 1);
}

int main() {
    printf("Enter a statement (e.g., a = b + c * d;):\n");
    return yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}
