%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

%%

[0-9]+                 { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
"="                    { return '='; }
";"                    { return ';'; }
"+"                    { return '+'; }
"-"                    { return '-'; }
"*"                    { return '*'; }
"/"                    { return '/'; }
[ \t\n]                ;  // ignore whitespace
.                      { return yytext[0]; }
