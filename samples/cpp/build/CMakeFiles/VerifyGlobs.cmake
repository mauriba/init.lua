# CMAKE generated file: DO NOT EDIT!
# Generated by CMake Version 3.30
cmake_policy(SET CMP0009 NEW)

# common_private_sources at lib/common/CMakeLists.txt:2 (file)
file(GLOB_RECURSE NEW_GLOB LIST_DIRECTORIES false "/c/Users/Maurice/AppData/Local/nvim/samples/cpp/lib/common/*.cpp")
set(OLD_GLOB
  "/c/Users/Maurice/AppData/Local/nvim/samples/cpp/lib/common/Shader.cpp"
  )
if(NOT "${NEW_GLOB}" STREQUAL "${OLD_GLOB}")
  message("-- GLOB mismatch!")
  file(TOUCH_NOCREATE "/c/Users/Maurice/AppData/Local/nvim/samples/cpp/build/CMakeFiles/cmake.verify_globs")
endif()

# common_public_sources at lib/common/CMakeLists.txt:1 (file)
file(GLOB_RECURSE NEW_GLOB LIST_DIRECTORIES false "/c/Users/Maurice/AppData/Local/nvim/samples/cpp/lib/common/*.hpp")
set(OLD_GLOB
  "/c/Users/Maurice/AppData/Local/nvim/samples/cpp/lib/common/Shader.hpp"
  )
if(NOT "${NEW_GLOB}" STREQUAL "${OLD_GLOB}")
  message("-- GLOB mismatch!")
  file(TOUCH_NOCREATE "/c/Users/Maurice/AppData/Local/nvim/samples/cpp/build/CMakeFiles/cmake.verify_globs")
endif()
