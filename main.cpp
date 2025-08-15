#include "MiniJavaLexerImpl.hpp"
#include "minijavaparser.gen.hpp"

int main()
{
    MiniJavaLexerImpl lexer{};
    yy::parser parser(lexer);
    return parser();
}