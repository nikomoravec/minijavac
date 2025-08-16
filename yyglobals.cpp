#include "yyglobals.hpp"

#include "MiniJavaLexerImpl.hpp"

int yylex(yy::parser::semantic_type* yylval)
{
    return yyglobals::g_lexer.yylex(yylval);
}

void yyglobals::setInputStream(std::istream& stream)
{
    g_lexer.switch_streams(&stream);
}
