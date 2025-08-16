%require "3.2"
%language "c++"

%code requires {
    #include <string>
    #include "Type.hpp"
}

%define api.value.type variant

%header

%code {
    int yylex(yy::parser::semantic_type* yylval);
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
%token <std::string> IDENTIFIER "identifier"
%token T_EOF 0 "end of file"

%type <minijavac::Type> Type

%start program

%%
program: ClassDeclarations;

ClassDeclaration: CLASS IDENTIFIER OPEN_BRACE OptionalExtends
{
}
VarDeclarations
CLOSE_BRACE;

ClassDeclarations
    :
    | ClassDeclarations ClassDeclaration
    ;

OptionalExtends
    : 
    | EXTENDS IDENTIFIER
    ;

VarDeclaration: Type IDENTIFIER SEMICOLON

VarDeclarations
    :
    | VarDeclarations VarDeclaration
    ;

Type
    : 
    INT OPEN_BRACKET CLOSE_BRACKET { $$ = minijavac::Type(minijavac::Type::Kind::INTEGER_ARRAY); }
    | INT { $$ = minijavac::Type(minijavac::Type::Kind::INTEGER); }
    | BOOLEAN { $$ = minijavac::Type(minijavac::Type::Kind::BOOLEAN); }
    | STRING { $$ = minijavac::Type(minijavac::Type::Kind::STRING); }
    | IDENTIFIER { $$ = minijavac::Type(minijavac::Type::Kind::IDENTIFIER); }
    ;
%%

void yy::parser::error(const std::string& message)
{
    throw yy::parser::syntax_error(message);
}
