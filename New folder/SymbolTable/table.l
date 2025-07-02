%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TABLE_SIZE 100

// Symbol Table Structure
typedef struct Symbol {
    char name[100];
    struct Symbol* next;
} Symbol;

Symbol* symbolTable[TABLE_SIZE];

// Hash function
unsigned int hash(const char* str) {
    unsigned int hash = 0;
    while (*str) {
        hash = (hash * 31) + *str;
        str++;
    }
    return hash % TABLE_SIZE;
}

// Insert or Retrieve from Symbol Table
Symbol* lookup(const char* name) {
    unsigned int index = hash(name);
    Symbol* entry = symbolTable[index];
    while (entry) {
        if (strcmp(entry->name, name) == 0) {
            printf("Identifier already exists: %s at address %p\n", name, (void*)entry);
            return entry;
        }
        entry = entry->next;
    }
    // If not found, insert new identifier
    Symbol* newEntry = (Symbol*)malloc(sizeof(Symbol));
    strcpy(newEntry->name, name);
    newEntry->next = symbolTable[index];
    symbolTable[index] = newEntry;
    printf("New identifier added: %s at address %p\n", name, (void*)newEntry);
    return newEntry;
}

%}

%%
[ \t\n]+                 ;
"/"[^]\+([^/][^]\+)*"/\n"   ;
"//".*                  ; 

auto | break | case | char | const | continue | default | do | double | else | enum | extern | float | for | goto | if | inline | int | long | register | restrict | return | short | signed | sizeof | static | struct | switch | typedef | union | unsigned | void | volatile | while   { printf("Keyword: %s\n",yytext); }

[a-zA-Z_][a-zA-Z0-9_]*  {
                            lookup(yytext);
                        }

[0-9]+                  { printf("Number: %s\n", yytext); }

[\+\-\*/%=<>!&\|\^~]+    { printf("Operator: %s\n", yytext); }

.                       ;
%%

int main() {
    for (int i = 0; i < TABLE_SIZE; i++) {
        symbolTable[i] = NULL;
    }
    yylex(); // Start lexing
    return 0;
}