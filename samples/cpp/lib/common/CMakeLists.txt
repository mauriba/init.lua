file(GLOB_RECURSE common_public_sources CONFIGURE_DEPENDS *.hpp)
file(GLOB_RECURSE common_private_sources CONFIGURE_DEPENDS *.cpp)

add_library(common "")

target_sources(common
    PUBLIC ${common_public_sources}
    PRIVATE ${common_private_sources}
)
