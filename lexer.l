%{

#include <stdio.h>

int yylex();

%}

%%

[a-z]+ {printf("%s\n", yytext);}

%%

int main()
{
    yylex();
}
