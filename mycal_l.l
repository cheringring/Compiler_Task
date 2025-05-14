%{

/*
 *	lexical analyzer for desk calculator
 */

#include	"y.tab.h"
#define		token(x)	x
extern int yylval;

%}

%%

[0-9]+		{ yylval = atoi(yytext); return YConstant;	}
[ \t]+		{ ;						}
[\n]		{ return token(YNL);				}
"+"		{ return token(YPLUS);				}
"-"		{ return token(YMINUS);				}
"*"		{ return token(YMUL);				}
"/"		{ return token(YDIV);				}
"("		{ return token(YLP);				}
")"		{ return token(YRP);				}
