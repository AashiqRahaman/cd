%{
#include <stdio.h>
%}

%option noyywrap


%%

"int"           { printf("Keyword: int\n"); }
"float"         { printf("Keyword: float\n"); }
"if"            { printf("Keyword: if\n"); }
"else"          { printf("Keyword: else\n"); }
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Identifier: %s\n", yytext); }
[0-9]+          { printf("Number: %s\n", yytext); }
"+"             { printf("Operator: +\n"); }
"-"             { printf("Operator: -\n"); }
"*"             { printf("Operator: *\n"); }
"/"             { printf("Operator: /\n"); }
"="             { printf("Assignment: =\n"); }
";"             { printf("Semicolon: ;\n"); }
"{"             { printf("Opening brace: {\n"); }
"}"             { printf("Closing brace: }\n"); }
[ \t\n]         ; // Ignore whitespace

.               { printf("Unknown: %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}
