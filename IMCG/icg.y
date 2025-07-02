%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;
char* newTemp();
void yyerror(const char *s);
int yylex();
%}

%union {
    char* str;
}

%token <str> ID
%token ASSIGN PLUS MINUS MUL DIV MOD SEMICOLON
%type <str> stmt expr

%left PLUS MINUS
%left MUL DIV MOD
%right UMINUS

%start program

%%

program
    : program stmt
    | /* empty */
    ;

stmt
    : ID ASSIGN expr SEMICOLON {
        printf("%s = %s\n", $1, $3);
    }
    ;

expr
    : expr PLUS expr {
        char* t = newTemp();
        printf("%s = %s + %s\n", t, $1, $3);
        $$ = t;
    }
    | expr MINUS expr {
        char* t = newTemp();
        printf("%s = %s - %s\n", t, $1, $3);
        $$ = t;
    }
    | expr MUL expr {
        char* t = newTemp();
        printf("%s = %s * %s\n", t, $1, $3);
        $$ = t;
    }
    | expr DIV expr {
        char* t = newTemp();
        printf("%s = %s / %s\n", t, $1, $3);
        $$ = t;
    }
    | expr MOD expr {
        char* t = newTemp();
        printf("%s = %s %% %s\n", t, $1, $3);
        $$ = t;
    }
    | MINUS expr %prec UMINUS {
        char* t = newTemp();
        printf("%s = -%s\n", t, $2);
        $$ = t;
    }
    | ID {
        $$ = $1;
    }
    ;

%%

char* newTemp() {
    char* name = (char*)malloc(10);
    sprintf(name, "t%d", tempCount++);
    return name;
}

void yyerror(const char *s) {
    // Optional: printf("Syntax error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
