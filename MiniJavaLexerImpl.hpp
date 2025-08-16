#pragma once

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "minijavaparser.gen.hpp"

class MiniJavaLexerImpl : public yyFlexLexer
{
public:
    int yylex(yy::parser::semantic_type* yylval);
};
