cmake_minimum_required(VERSION 3.10)

project(test VERSION 1.0.0)

if (NOT CMAKE_BUILD_TYPE)
    set (CMAKE_BUILD_TYPE Debug)
endif()

message(STATUS "##########################################################")
message(STATUS "PROJECT_NAME: ${PROJECT_NAME}")
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")

message(STATUS "CMAKE_PROJECT_NAME: ${CMAKE_PROJECT_NAME}")
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "CMAKE_CURRRENT_BINARY_DIR: ${CMAKE_CURRENT_BINARY_DIR}")


message(STATUS "##########################################################")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# 指定操作系统名称
set(CMAKE_SYSTEM_NAME Linux)

# 指定c++的标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# 指定C语言的标准
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# 指定编译标志
SET (CMAKE_C_COMPILER             "/usr/bin/clang")
SET (CMAKE_C_FLAGS                "-Wall -std=c99")
SET (CMAKE_C_FLAGS_DEBUG          "-g -v")
SET (CMAKE_C_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
SET (CMAKE_C_FLAGS_RELEASE        "-O4 -DNDEBUG")
SET (CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g")
 
SET (CMAKE_CXX_COMPILER             "/usr/bin/clang++")
SET (CMAKE_CXX_FLAGS                "-Wall")
SET (CMAKE_CXX_FLAGS_DEBUG          "-g -v")
SET (CMAKE_CXX_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
SET (CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")
SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")
 
SET (CMAKE_AR      "/usr/bin/llvm-ar")
SET (CMAKE_LINKER  "/usr/bin/llvm-ld")
SET (CMAKE_NM      "/usr/bin/llvm-nm")
SET (CMAKE_OBJDUMP "/usr/bin/llvm-objdump")
SET (CMAKE_RANLIB  "/usr/bin/llvm-ranlib")

# 设置exe/so目录
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
set(BUILD_SOURCE_DIR ${PROJECT_SOURCE_DIR}/src)

# 设置src/include目录
list(APPEND INCS_LIST ${BUILD_SOURCE_DIR})

if (EXISTS test)
    add_subdirectory(test)
endif()

add_definitions(-DDEBUG)

# 生成静态库
set(STATIC_DIR ${BUILD_SOURCE_DIR}/static)
if (EXISTS ${STATIC_DIR})
    aux_source_directory(${STATIC_DIR} STATIC_SRC_LIST)
    add_library(static STATIC ${STATIC_SRC_LIST})
    list(APPEND LIBS_LIST static)
    list(APPEND INCS_LIST ${STATIC_DIR})
endif()

# 生成动态库
set(SHARED_DIR ${BUILD_SOURCE_DIR}/shared)
if (EXISTS ${SHARED_DIR})
    aux_source_directory(${SHARED_DIR} SHARED_SRC_LIST)
    add_library(shared SHARED ${SHARED_SRC_LIST})
    list(APPEND LIBS_LIST shared)
    list(APPEND INCS_LIST ${SHARED_DIR})
endif()

# 添加头文件路径
foreach(d ${INCS_DIR_LIST})
    include_directories(${d})
endforeach()

# 编译main，生成可执行文件
add_executable(main ${BUILD_SOURCE_DIR}/main.cpp)

if (${LIBS_LIST})
    target_link_libraries(main ${LIBS_LIST})
endif()
