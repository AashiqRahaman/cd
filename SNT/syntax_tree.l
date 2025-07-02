%{
#include "syntax_tree.tab.h"
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
[ \t\n]                ; // ignore whitespace
.                      { return yytext[0]; }
