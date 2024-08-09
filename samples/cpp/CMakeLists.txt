cmake_minimum_required(VERSION 3.16)

project(CppBuildExample VERSION 0.0 LANGUAGES CXX)
# INFO: Export a compile_commands.json file for clangd lsp to recognize project includes
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_BUILD_TYPE Debug)

add_subdirectory(lib)

add_executable(opengl-cube "opengl-cube.cpp")
add_compile_options(-g)

# Copy shaders
add_custom_target(CopyShaders ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_CURRENT_SOURCE_DIR}/shaders
    ${PROJECT_BINARY_DIR}/shaders
)
add_dependencies(opengl-cube CopyShaders)

# -lm -lglew32 -lfreeglut -lopengl32 -Wl,--subsystem,windows
target_include_directories(opengl-cube PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/lib)
target_link_libraries(opengl-cube PUBLIC common PRIVATE m GL GLU GLEW  glfw)  # linux
# target_link_libraries(opengl-cube PUBLIC common PRIVATE m glew32 opengl32 glfw3)   # windows 
