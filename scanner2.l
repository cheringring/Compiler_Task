%{
#include "pascal.tab.h"
#include <stdlib.h>
#define token(x) x
#define EndTable(v) (&v[sizeof(v)/sizeof(v[0])-1])
int screen();
int addword(int type, char *word);
int lookup_word(char *word);
#define constant 1
#define identifier 2
#define NOTFOUND -1
%}
%%
":="	{ return(YASSIGN);}
":"	{ return(YCOLON);}
","	{ return(YCOMMA);}
"."	{ return(YDOT);}
"="	{ return(YEQUALS);}
"*"	{ return(YMULT);}
"+"	{ return(YPLUS);}
";"	{ return(YSEMICOL);}
[0-9]+  { return(YINTNUMBER); }
"BEGIN" { return(YBEGIN); }
"CONST" { return(YCONST); }
"END"   { return(YEND); }
"INTEGER" { return(YINTEGER); }
"PROGRAM" { return(YPROGRAM); }
"VAR"   { return(YVAR); }
[a-zA-Z_][a-zA-Z0-9]* { return(YIDENTIFIER); }

[ \t\n] ;

%%
static struct rwtable{
	char *rw_name;
	int rw_yylex;
} rwtable[] = {
	"BEGIN",	token(YBEGIN),
	"CONST",	token(YCONST),
	"END",		token(YEND),
        "INTEGER",      token(YINTEGER),
	"PROGRAM",	token(YPROGRAM),
	"VAR",		token(YVAR),
};

struct word{
	char *word_name;
	int word_type;
	char *value; 
	struct word *next;
};

struct word *word_list = NULL;


int addword(int type, char *word)
{
	struct word *wp;

	wp = (struct word *) malloc(sizeof(struct word));
	wp->next = word_list;
	wp->word_name = (char *) malloc(strlen(word)+1);

	if(type == constant){
		wp->value = (char *) malloc(strlen(word)+1);
		strcpy(wp->value, word);
	}
	else{
		strcpy(wp->word_name, word);
	}

	wp->word_type = type;
	word_list = wp;
	return 1;
}

int lookup_word(char *word)
{
	struct word *wp = word_list;

	for(;wp;wp = wp->next){
		if(strcmp(wp->word_name, word) == 0)
			return(wp->word_type);
	}
	return NOTFOUND;
}

int screen()
{
	struct rwtable *low = rwtable,
			*high = EndTable(rwtable),
			*mid;
	int c;

	while(low <= high){
		mid = low + (high - low)/2;
		if((c = strcmp(mid->rw_name, yytext)) == 0){
			return(mid->rw_yylex);
		}
		else{
			if(c < 0) 
				low = mid + 1;
			else
				high = mid - 1;
		}
	}
	if(lookup_word(yytext) != NOTFOUND){
		return(YIDENTIFIER);
	}
	else{
		addword(identifier, yytext);
		return(YIDENTIFIER);
	}	
}
