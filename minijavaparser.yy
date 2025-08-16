%require "3.2"
%language "c++"

%code requires {
    #include <string>
    #include <variant>
    #include "fmt/format.h"
    #include "MiniJavaLexerImpl.hpp"
}

%define api.value.type {std::variant<int32_t, std::string, bool>}

%parse-param {MiniJavaLexerImpl& lexer}

%header

%code {
    #define yylex lexer.yylex
}

// %locations
%define parse.error verbose
%define parse.lac full

%token ASSIGN "="
%token OPEN_PARENTHESIS "("
%token CLOSE_PARENTHESIS ")"
%token OPEN_BRACKET "["
%token CLOSE_BRACKET "]"
%token OPEN_BRACE "{"
%token CLOSE_BRACE "}"
%token SEMICOLON ";"
%token COMMA ","
%token AND_OP "&&"
%token LESS_THAN_OP "<"
%token PLUS_OP "+"
%token MINUS_OP "-"
%token MULTIPLICATION_OP "*"
%token DOT "."
%token NOT_OP "!"
%token CLASS "class" 
%token EXTENDS "extends"
%token PUBLIC "public"
%token STATIC "static"
%token VOID "void"
%token MAIN_CLASS "main"
%token STRING "String"
%token RETURN "return"
%token BOOLEAN "boolean"
%token INT "int"
%token IF "if"
%token ELSE "else"
%token WHILE "while"	
%token PRINT "System.out.println"
%token LENGTH "length"
%token THIS "this"
%token NEW "new"
%token <int32_t> INTEGER_LITERAL "integer literal"
%token <std::string> STRING_LITERAL "string literal"
%token <bool> BOOLEAN_LITERAL "boolean literal"
%token <string> IDENTIFIER "identifier"
%token T_EOF 0 "end of file"


%start program

%%
program: %empty
%%

void yy::parser::error(const std::string& message)
{
    throw yy::parser::syntax_error(message);
}
