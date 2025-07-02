%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
%}

%union {
    char* str;
}

%token <str> ID
%type <str> stmt expr

%left '+' '-'
%left '*' '/'

%%

stmt : ID '=' expr ';' {
           printf("Parsed: %s = %s\n", $1, $3);
           free($1);
           free($3);
       }
     ;

expr : expr '+' expr {
           char *t = malloc(100);
           sprintf(t, "(%s + %s)", $1, $3);
           free($1); free($3);
           $$ = t;
       }
     | expr '-' expr {
           char *t = malloc(100);
           sprintf(t, "(%s - %s)", $1, $3);
           free($1); free($3);
           $$ = t;
       }
     | expr '*' expr {
           char *t = malloc(100);
           sprintf(t, "(%s * %s)", $1, $3);
           free($1); free($3);
           $$ = t;
       }
     | expr '/' expr {
           char *t = malloc(100);
           sprintf(t, "(%s / %s)", $1, $3);
           free($1); free($3);
           $$ = t;
       }
     | ID {
           $$ = $1;
       }
     ;

%%

int main() {
    printf("Enter a statement (e.g., a = b + c;):\n");
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}
