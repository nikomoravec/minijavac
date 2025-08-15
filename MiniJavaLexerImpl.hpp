#pragma once

#include <string>

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

class MiniJavaLexerImpl : public yyFlexLexer
{
public:
    int yylex(std::string* const yylval);
};
