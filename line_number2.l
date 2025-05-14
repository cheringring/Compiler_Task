%{
/*
 * line numbering 2
 */
int lineno = 0;
%}

%option noyywrap 

%%
^.*\n    { printf("%d\t%s", ++lineno, yytext); }
%%

int main() {
    yylex();
    return 0;
}

