#pragma once

#include "MiniJavaLexerImpl.hpp"
#include <istream>

class yyglobals final
{
    friend int yylex(yy::parser::semantic_type* yylval);

public:
    yyglobals() = delete;
    ~yyglobals() = delete;

    static void setInputStream(std::istream& stream);

private:
    static inline MiniJavaLexerImpl g_lexer {};
};
