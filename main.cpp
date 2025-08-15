#include "MiniJavaLexerImpl.hpp"
#include "fmt/base.h"
#include "minijavaparser.gen.hpp"
#include <fstream>

int main(int argc, char** argv)
{
    if(argc < 2)
    {
        fmt::println(stderr, "usage: ./minijavac <path/to/source/file>");
        return 0;
    }

    std::ifstream fs{argv[1]};
    if(!fs.is_open())
    {
        fmt::println(stderr, "Failed to open \"{}\" source file", argv[1]);
        return 0;
    }
    
    MiniJavaLexerImpl lexer{};
    lexer.switch_streams(&fs);
    yy::parser parser(lexer);
    return parser.parse();
}