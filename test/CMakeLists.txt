cmake_minimum_required(VERSION 3.14...3.22)

project(UseCudaLibTests LANGUAGES CXX CUDA)

# ---- Options ----

option(ENABLE_TEST_COVERAGE "Enable test coverage" OFF)
option(TEST_INSTALLED_VERSION "Test the version found by find_package" OFF)

# --- Import tools ----

include(../cmake/tools.cmake)

# ---- Dependencies ----

include(../cmake/CPM.cmake)

CPMAddPackage("gh:doctest/doctest@2.4.9")
CPMAddPackage("gh:TheLartians/Format.cmake@1.7.3")

if(TEST_INSTALLED_VERSION)
  find_package(UseCudaLib CONFIG REQUIRED PATHS ${CMAKE_CURRENT_SOURCE_DIR}/../install)
else()
  CPMAddPackage(NAME UseCudaLib SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..)
endif()

# ---- Create binary ----

file(GLOB sources CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp)
add_executable(${PROJECT_NAME} ${sources})
target_link_libraries(${PROJECT_NAME} doctest::doctest UseCudaLib::UseCudaLib)
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 20)


message(STATUS "CMAKE_CUDA_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
# enable compiler warnings
if(NOT TEST_INSTALLED_VERSION)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    #target_compile_options(UseCudaLib PUBLIC -Wall -Wpedantic -Wextra -Werror)
    target_compile_options(UseCudaLib PUBLIC 
      $<$<COMPILE_LANGUAGE:CXX>:-Wall -Wpedantic -Wextra -Werror>
      $<$<COMPILE_LANGUAGE:CUDA>:--compiler-options=-Wall,-Wextra,-Werror>
    )
  elseif(MSVC)
    target_compile_options(UseCudaLib PUBLIC /W4 /WX)
    target_compile_definitions(${PROJECT_NAME} PUBLIC DOCTEST_CONFIG_USE_STD_HEADERS)
  endif()
endif()

# ---- Add GreeterTests ----

enable_testing()

# Note: doctest and similar testing frameworks can automatically configure CMake tests. For other
# testing frameworks add the tests target instead: add_test(NAME ${PROJECT_NAME} COMMAND
# ${PROJECT_NAME})

include(${doctest_SOURCE_DIR}/scripts/cmake/doctest.cmake)
doctest_discover_tests(${PROJECT_NAME})

install(TARGETS ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

# ---- code coverage ----

if(ENABLE_TEST_COVERAGE)
  target_compile_options(UseCudaLib PUBLIC -O0 -g -fprofile-arcs -ftest-coverage)
  target_link_options(UseCudaLib PUBLIC -fprofile-arcs -ftest-coverage)
endif()
