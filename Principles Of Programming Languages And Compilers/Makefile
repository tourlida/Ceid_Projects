default: 
	bison -d -y my_parser.y
	flex XML_syntax_4.l
	gcc -c y.tab.c lex.yy.c
	gcc y.tab.o lex.yy.o -o parser

