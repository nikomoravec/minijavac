#pragma once

#include <string>
#include <variant>

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

class MiniJavaLexerImpl : public yyFlexLexer
{
public:
    int yylex(std::variant<int32_t, std::string, bool>* yylval);
};
