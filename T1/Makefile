all:
	bison -d parser.y
	flex lexer.l
	gcc parser.tab.c lex.yy.c -o syntax_checker

clean:
	rm -f syntax_checker parser.tab.c parser.tab.h lex.yy.c
