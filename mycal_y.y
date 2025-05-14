%{
#include <stdio.h>
#define YYSTYPE int  // 명시적 타입 선언
extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);
%}

%token	YConstant
%token	YLP
%token	YRP
%token	YNL
%token	YPLUS
%token	YMINUS
%token	YMUL
%token	YDIV

%left	YPLUS	YMINUS
%left	YMUL	YDIV

%start	line

%%

line
	: line expression YNL			{ printf("%d\n", $2);	}
	|					/*	empty		*/
	;
expression
	: expression YPLUS expression		{ $$ = $1 + $3;	}
	| expression YMINUS expression		{ $$ = $1 - $3;	}
	| expression YMUL expression		{ $$ = $1 * $3;	}
	| expression YDIV expression		{ $$ = $1 / $3;	}
	| YLP expression YRP			{ $$ = $2;	}
	| YConstant				{ yyval = $1; } 
	;

%%

int main()
{
    yyin = stdin;
	while(!feof(yyin))
	{
		yyparse();
	}
    return 0;
}
void yyerror(const char *s)
{
	fprintf(stderr,"%s\n",s);
}
