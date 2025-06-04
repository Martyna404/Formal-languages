%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int yylex();
void yyerror(const char *s);
extern int yylineno;
int syntax_error = 0;

void free_str(char *s) {
    if (s) free(s);
}
%}

%union {
    char *str;
}

%token <str> IDENTIFIER
%token INT CHAR DOUBLE
%token STAR SEMICOLON COMMA LPAREN RPAREN
%token ERROR NEWLINE
%type <str> identifier type

%%

input:
    /* empty */
    | input line
    ;

line:
      declaration SEMICOLON NEWLINE {
          if (syntax_error) {
              printf("ERROR\n");
              syntax_error = 0;
          } else {
              printf("OK\n");
          }
      }
    | error NEWLINE {
          printf("ERROR\n");
          syntax_error = 0;
          yyerrok;
      }
    | NEWLINE
    ;

declaration:
    type pointer_opt identifier decl_tail {
        if ($3 == NULL) syntax_error = 1;
        free_str($1);
        free_str($3);
    }
    ;

decl_tail:
    /* empty */
    | LPAREN param_list RPAREN
    ;

param_list:
    /* empty */
    | params
    ;

params:
    param
    | params COMMA param
    ;

param:
    type pointer_opt identifier {
        if ($3 == NULL) syntax_error = 1;
        free_str($1);
        free_str($3);
    }
    ;

type:
    INT    { $$ = strdup("int"); }
    | CHAR   { $$ = strdup("char"); }
    | DOUBLE { $$ = strdup("double"); }
    | ERROR  { syntax_error = 1; $$ = NULL; }
    ;

pointer_opt:
    /* empty */
    | STAR pointer_opt
    ;

identifier:
    IDENTIFIER {
        if (!isalpha($1[0]) && $1[0] != '_') {
            syntax_error = 1;
            free($1);
            $$ = NULL;
        } else {
            $$ = $1;
        }
    }
    | ERROR {
        syntax_error = 1;
        $$ = NULL;
    }
    ;

%%

void yyerror(const char *s) {
    syntax_error = 1;
}

int main() {
    yyparse();
    return 0;
}