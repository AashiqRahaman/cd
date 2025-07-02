%{
#include "icg.tab.h"
#include <string.h>
%}

%option noyywrap

%%

[ \t\n]                ; // Ignore whitespace
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
"="                   { return ASSIGN; }
"+"                   { return PLUS; }
"-"                   { return MINUS; }
"*"                   { return MUL; }
"/"                   { return DIV; }
"%"                   { return MOD; }
";"                   { return SEMICOLON; }

.                     { return yytext[0]; }
