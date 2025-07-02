%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

%%

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
"="                    { return '='; }
";"                    { return ';'; }
"+"                    { return '+'; }
"-"                    { return '-'; }
"*"                    { return '*'; }
"/"                    { return '/'; }
[ \t\n]                ; // skip whitespace
.                      { return yytext[0]; }
