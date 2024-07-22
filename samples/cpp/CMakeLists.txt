cmake_minimum_required(VERSION 3.16)

project(CppBuildExample VERSION 0.0 LANGUAGES CXX)

add_subdirectory(lib)

add_executable(opengl-cube "opengl-cube.cpp")

# Copy shaders
add_custom_target(CopyShaders ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_CURRENT_SOURCE_DIR}/shaders
    ${PROJECT_BINARY_DIR}/shaders
)
add_dependencies(opengl-cube CopyShaders)

# -lm -lglew32 -lfreeglut -lopengl32 -Wl,--subsystem,windows
target_include_directories(opengl-cube PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/lib)
target_link_libraries(opengl-cube PUBLIC common PRIVATE m glew32 opengl32 glfw3)
