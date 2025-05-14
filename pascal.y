%{
#include <stdio.h>
extern int yylex(void);
extern void yyerror(const char *);
%}
%token YASSIGN YBEGIN YCOLON YCOMMA YCONST YDOT YEND YEQUALS
%token YIDENTIFIER YINTEGER YINTNUMBER YMULT YPLUS YPROGRAM YSEMICOL YVAR
%start pascalProgram

%%
pascalProgram
	: programHeading YSEMICOL block1 YDOT
		{ printf("parsing completed.\n"); }
	;
programHeading
	: YPROGRAM YIDENTIFIER
	;
block1
	: constantDecl YSEMICOL block2
	;
constantDecl
	: YCONST YIDENTIFIER YEQUALS YINTNUMBER
	| constantDecl YSEMICOL YIDENTIFIER YEQUALS YINTNUMBER
	;
block2
	: variableDecl YSEMICOL block3
	;
variableDecl
	: YVAR variableIdList YCOLON YINTEGER
	;
variableIdList
	: YIDENTIFIER
	| variableIdList YCOMMA YIDENTIFIER
	;
block3
	: YBEGIN stmtList YEND
	;
stmtList
	: stmt
	| stmtList YSEMICOL stmt
	;
stmt
	: variable YASSIGN simpleExpression
	;
variable
	: YIDENTIFIER
	;
simpleExpression
	: term
	| simpleExpression YPLUS term
	| simpleExpression YMULT term
	;
term
	: YIDENTIFIER
	| YINTNUMBER
	;
%%
extern FILE *yyin;
int main()
{
    yyin = stdin;
	while(!feof(yyin)){
	   yyparse();
	}
    return 0;
}

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}
