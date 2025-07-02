%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 10

typedef struct Node {
    char *identifier;
    struct Node *next;
} Node;

Node *hashTable[TABLE_SIZE];

// Hash function
int hashFunction(char *id) {
    int sum = 0;
    for (int i = 0; id[i] != '\0'; i++) {
        sum += id[i];
    }
    return sum % TABLE_SIZE;
}

// Search for an identifier in the hash table
Node *search(char *id) {
    int index = hashFunction(id);
    Node *current = hashTable[index];
    while (current != NULL) {
        if (strcmp(current->identifier, id) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

// Insert a new identifier into the hash table
Node *insert(char *id) {
    int index = hashFunction(id);
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->identifier = strdup(id);
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
    return newNode;
}
%}

%option noyywrap

%%
[a-zA-Z][a-zA-Z0-9]* {
    char *id = yytext;
    Node *result = search(id);
    if (result != NULL) {
        printf("Identifier '%s' already exists at address: %p\n", id, result);
    } else {
        Node *newEntry = insert(id);
        printf("Inserted identifier '%s' at address: %p\n", id, newEntry);
    }
}
%%

int main() {
    yylex();
    return 0;
}

// run using 
/*
$ lex table.l
$ gcc lex.yy.c -o lexer
$ ./lexer <symbol_input.c      or |   $ ./lexer then input c 

*/