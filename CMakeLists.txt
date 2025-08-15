cmake_minimum_required(VERSION 3.11)
project(minijavac)

set(CMAKE_CXX_STANDARD 20)

include(FetchContent)

FetchContent_Declare(fmt GIT_REPOSITORY https://github.com/fmtlib/fmt.git GIT_TAG 11.2.0)

FetchContent_MakeAvailable(fmt)

find_package(FLEX 2.6 REQUIRED)
find_package(BISON 3.2 REQUIRED)

set(PARSER_DIR "${CMAKE_CURRENT_BINARY_DIR}")
set(LEXER_OUT "${PARSER_DIR}/lexer.c")
set(PARSER_OUT "${PARSER_DIR}/parser.c")

flex_target(LEXER "lexer.l" ${LEXER_OUT} DEFINES_FILE "${PARSER_DIR}/lexer.h")
bison_target(PARSER "parser.y" "${PARSER_OUT}" DEFINES_FILE "${PARSER_DIR}/parser.h")
add_flex_bison_dependency(LEXER PARSER)

add_executable(minijavac
    lexer.c
    parser.c
    main.cpp
)

target_link_libraries(minijavac PUBLIC
    fmt
)

