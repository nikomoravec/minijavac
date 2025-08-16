%{

#include "fmt/format.h"

#include "MiniJavaLexerImpl.hpp"
#include "minijavaparser.gen.hpp"

#undef  YY_DECL
#define YY_DECL int MiniJavaLexerImpl::yylex(yy::parser::semantic_type* yylval)

%}

%option yyclass="MiniJavaLexerImpl"
%option noyywrap
%option c++

line_comment "//"[^\r\n]*
multi_line_comment "/*"([^"*"]|("*")*[^"*/"])*("*")*"*/"
identifier [A-Za-z_][A-Za-z0-9_]*
integer_literal	[+-]?[1-9][0-9]*
boolean_literal	true|false
escape_sequence \\[bfnrt"\\]
string_literal "\""([^"\\\r\n]|{escape_sequence})*"\""
illegal_identifier [0-9][a-zA-Z0-9]+
whitespace [ \t\v\f\r]*

%%

[ \t]+               // skip whitespaces
"\n"                 // skip new lines

"="                  { return yy::parser::token::ASSIGN; }
"("                  { return yy::parser::token::OPEN_PARENTHESIS; }
")"                  { return yy::parser::token::CLOSE_PARENTHESIS; }
"["                  { return yy::parser::token::OPEN_BRACKET; }
"]"                  { return yy::parser::token::CLOSE_BRACKET; }
"{"                  { return yy::parser::token::OPEN_BRACE; }
"}"                  { return yy::parser::token::CLOSE_BRACE; }
";"                  { return yy::parser::token::SEMICOLON; }
","                  { return yy::parser::token::COMMA; }
"&&"                 { return yy::parser::token::AND_OP; }
"<"                  { return yy::parser::token::LESS_THAN_OP; }
"+"                  { return yy::parser::token::PLUS_OP; }
"-"                  { return yy::parser::token::MINUS_OP; }
"*"                  { return yy::parser::token::MULTIPLICATION_OP; }
"."                  { return yy::parser::token::DOT; }
"!"                  { return yy::parser::token::NOT_OP; }
"class"              { return yy::parser::token::CLASS; }
"extends"            { return yy::parser::token::EXTENDS; }
"public"             { return yy::parser::token::PUBLIC; }
"static"             { return yy::parser::token::STATIC; }
"void"               { return yy::parser::token::VOID; }
"String"             { return yy::parser::token::STRING; }
"return"             { return yy::parser::token::RETURN; }
"boolean"            { return yy::parser::token::BOOLEAN; }
"int"                { return yy::parser::token::INT; }
"if"                 { return yy::parser::token::IF; }
"else"               { return yy::parser::token::ELSE; }
"while"              { return yy::parser::token::WHILE; }
"System.out.println" { return yy::parser::token::PRINT; }
"length"             { return yy::parser::token::LENGTH; }
"this"               { return yy::parser::token::THIS; }
"new"                { return yy::parser::token::NEW; }


{integer_literal}    { yylval->emplace<int32_t>(std::stoi(yytext)); return yy::parser::token::INTEGER_LITERAL; }
{string_literal}     { yylval->emplace<std::string>(yytext); return yy::parser::token::STRING_LITERAL; }
{illegal_identifier} { throw yy::parser::syntax_error(fmt::format("illegal identifier '{}' near line {}", yytext, yylineno)); }
{line_comment}       // skip line comments 
{multi_line_comment} // skip multiline comments
{whitespace}         // skip whitespaces
{boolean_literal}    { strcmp(yytext, "true") == 0 ? yylval->emplace<bool>(true) : yylval->emplace<bool>(false); return yy::parser::token::BOOLEAN_LITERAL; }
{identifier}         { yylval->emplace<std::string>(yytext); return yy::parser::token::IDENTIFIER; }

.                    { throw yy::parser::syntax_error(fmt::format("unexpected token '{}' near line {}", yytext, yylineno)); }

%%
