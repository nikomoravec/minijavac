%require "3.2"
%language "c++"

%code requires {
    #include <string>
    #include "fmt/format.h"
    #include "MiniJavaLexerImpl.hpp"
}

%define api.value.type {std::string}

%parse-param {MiniJavaLexerImpl& lexer}

%header

%code {
    #define yylex lexer.yylex
}

%start program

%%
program: %empty
%%

void yy::parser::error(const std::string& message)
{
    fmt::println(stderr, "error: {}", message);
}
