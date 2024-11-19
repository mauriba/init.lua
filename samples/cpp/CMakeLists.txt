cmake_minimum_required(VERSION 3.15)
project(Sample LANGUAGES CXX)

file(GLOB sources CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/*.cpp ${CMAKE_SOURCE_DIR}/*.hpp)
add_executable(sample ${sources})
