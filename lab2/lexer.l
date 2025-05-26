%{
#include "parser.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
"*"         { return TIMES; }
"="         { return EQUAL; }
[ \t\n]     ;             // ignoruj białe znaki
.           { return -1; }

%%
