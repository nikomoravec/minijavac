cmake_minimum_required(VERSION 3.11)
project(minijava++)

set(CMAKE_CXX_STANDARD 20)

include(FetchContent)

FetchContent_Declare(fmt GIT_REPOSITORY https://github.com/fmtlib/fmt.git GIT_TAG 11.2.0)

FetchContent_MakeAvailable(fmt)

add_executable(minijavac
    main.cpp
)

target_link_libraries(minijavac PUBLIC
    fmt
)
