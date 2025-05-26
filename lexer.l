%{
#include "parser.tab.h"
%}

%option noyywrap

%%
[abc]        { yylval.c = yytext[0]; return LETTER; }
[ \t\n]+     ;
%%