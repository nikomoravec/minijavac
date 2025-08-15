%{

#include "fmt/format.h"

#include "MiniJavaLexerImpl.hpp"
#include "minijavaparser.gen.hpp"

#undef  YY_DECL
#define YY_DECL int MiniJavaLexerImpl::yylex(std::string* const lval)

%}

%option yyclass="MiniJavaLexerImpl"
%option noyywrap
%option c++

%%

[a-z]+ {fmt::println("{}", yytext);}

%%
