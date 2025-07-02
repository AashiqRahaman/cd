%{
#include <stdio.h>
%}

DIGIT   [0-9]+
ID      [a-zA-Z_][a-zA-Z0-9_]*
WS      [ \t\n\r]+
COMMENT_SINGLE \/\/.*   
COMMENT_MULTI   \/\*([^*]|\*+[^*/])*\*+\/ 


%%
 // Ignore comments (both single-line and multi-line)
{COMMENT_SINGLE} { /* Ignore single-line comments */ }
{COMMENT_MULTI}  { /* Ignore multi-line comments */ }

"int"       { printf("TOKEN: KEYWORD_INT, LEXEME: %s\n", yytext); }
"return"    { printf("TOKEN: KEYWORD_RETURN, LEXEME: %s\n", yytext); }
"printf"    { printf("TOKEN: FUNCTION_PRINTF, LEXEME: %s\n", yytext); }
{ID}        { printf("TOKEN: IDENTIFIER, LEXEME: %s\n", yytext); }
"="         { printf("TOKEN: ASSIGNMENT, LEXEME: %s\n", yytext); }
{DIGIT}     { printf("TOKEN: NUMBER, LEXEME: %s\n", yytext); }
"("         { printf("TOKEN: LEFT_PAREN, LEXEME: %s\n", yytext); }
")"         { printf("TOKEN: RIGHT_PAREN, LEXEME: %s\n", yytext); }
"{"         { printf("TOKEN: LEFT_BRACE, LEXEME: %s\n", yytext); }
"}"         { printf("TOKEN: RIGHT_BRACE, LEXEME: %s\n", yytext); }
"\""        { printf("TOKEN: DOUBLE_QUOTE, LEXEME: %s\n", yytext); }
\"([^\\\"]|\\.)*\"   { printf("TOKEN: STRING_LITERAL, LEXEME: %s\n", yytext); }
";"         { printf("TOKEN: SEMICOLON, LEXEME: %s\n", yytext); }
"*"         { printf("TOKEN: MULTIPLICATION, LEXEME: %s\n", yytext); }
"/"         { printf("TOKEN: DIVISION, LEXEME: %s\n", yytext); }
"%"         { printf("TOKEN: MODULUS, LEXEME: %s\n", yytext); }
"+"         { printf("TOKEN: ADDITION, LEXEME: %s\n", yytext); }
"-"         { printf("TOKEN: SUBTRACTION, LEXEME: %s\n", yytext); }
{WS}        { /* Ignore whitespace */ }

.           { printf("TOKEN: UNKNOWN, LEXEME: %s\n", yytext); }

%%

int main() {
    yylex();  // Start scanning
    return 0;
}

int yywrap() {
    return 1;
}



// run using 
/*
$ lex table.l
$ gcc lex.yy.c -o lexer
$ ./lexer <lex_input.c

*/