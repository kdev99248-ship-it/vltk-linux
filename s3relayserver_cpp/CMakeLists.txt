cmake_minimum_required(VERSION 3.16)
project(s3relayserver_cpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(s3relayserver
    src/main.cpp
    src/relay_store.cpp
)

target_compile_options(s3relayserver PRIVATE -Wall -Wextra -Wpedantic)

# MySQL client (libmysqlclient) is the relay/account backend, unified with the
# Linux game database engine.
find_path(MYSQL_INCLUDE_DIR mysql/mysql.h)
find_library(MYSQL_LIBRARY NAMES mysqlclient libmysqlclient)

if(MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY)
    target_include_directories(s3relayserver PRIVATE ${MYSQL_INCLUDE_DIR})
    target_link_libraries(s3relayserver PRIVATE ${MYSQL_LIBRARY})
    target_compile_definitions(s3relayserver PRIVATE HAVE_MYSQL=1)
    message(STATUS "MySQL client enabled: ${MYSQL_LIBRARY}")
else()
    message(FATAL_ERROR "libmysqlclient is required for the MySQL relay backend")
endif()
