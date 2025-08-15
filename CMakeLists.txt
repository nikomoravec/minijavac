cmake_minimum_required(VERSION 3.11)
project(minijavac)

set(CMAKE_CXX_STANDARD 20)

include(FetchContent)

FetchContent_Declare(fmt GIT_REPOSITORY https://github.com/fmtlib/fmt.git GIT_TAG 11.2.0)

FetchContent_MakeAvailable(fmt)

find_package(FLEX 2.6 REQUIRED)
find_package(BISON 3.2 REQUIRED)

set(LEXER_HPP_OUT "${CMAKE_CURRENT_BINARY_DIR}/minijavalexer.gen.hpp")
set(LEXER_CPP_OUT "${CMAKE_CURRENT_BINARY_DIR}/minijavalexer.gen.cpp")
set(PARSER_HPP_OUT "${CMAKE_CURRENT_BINARY_DIR}/minijavaparser.gen.hpp")
set(PARSER_CPP_OUT "${CMAKE_CURRENT_BINARY_DIR}/minijavaparser.gen.cpp")

flex_target(LEXER "minijavalexer.ll" ${LEXER_CPP_OUT} DEFINES_FILE "${LEXER_HPP_OUT}")
bison_target(PARSER "minijavaparser.yy" "${PARSER_CPP_OUT}" DEFINES_FILE "${PARSER_HPP_OUT}")
add_flex_bison_dependency(LEXER PARSER)

add_executable(minijavac
    ${LEXER_HPP_OUT}
    ${LEXER_CPP_OUT}
    ${PARSER_HPP_OUT}
    ${PARSER_CPP_OUT}
    MiniJavaLexerImpl.hpp
    main.cpp
)

target_link_libraries(minijavac PRIVATE
    fmt
)

target_include_directories(minijavac PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}
)


