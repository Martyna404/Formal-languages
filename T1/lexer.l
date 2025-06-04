%{
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>

extern int yylineno;
%}

%option noinput nounput noyywrap

%%

[ \t]+                /* ignore whitespace */
\n                    { yylineno++; return NEWLINE; }

"//".*                /* ignore comments */
"/*"([^*]|\*+[^*/])*\*+"/"  /* ignore comments */

"int"                 { return INT; }
"char"                { return CHAR; }
"double"              { return DOUBLE; }

"*"                   { return STAR; }
";"                   { return SEMICOLON; }
","                   { return COMMA; }
"("                   { return LPAREN; }
")"                   { return RPAREN; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.str = strdup(yytext);
    if (!yylval.str) {
        fprintf(stderr, "Memory error\n");
        exit(1);
    }
    return IDENTIFIER;
}

[0-9]+[a-zA-Z_]+      { return ERROR; }
.                     { return ERROR; }

%%