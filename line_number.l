%{
#include <stdio.h>
int lineno = 1; 
%}

%% 

\n      { lineno++; ECHO; } 
^.*$    { printf("%d\t%s", lineno, yytext); }

%% 
int main() {
    yylex();
    return 0;
}

int yywrap() { 
    return 1; 
}
