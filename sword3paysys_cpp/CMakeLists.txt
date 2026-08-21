cmake_minimum_required(VERSION 3.16)
project(sword3paysys_cpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(sword3paysys
    src/main.cpp
    src/account_store.cpp
)

target_compile_options(sword3paysys PRIVATE -Wall -Wextra -Wpedantic)

# MySQL client (libmysqlclient) is the account/billing backend, unified with
# the Linux game database engine.
find_path(MYSQL_INCLUDE_DIR mysql/mysql.h)
find_library(MYSQL_LIBRARY NAMES mysqlclient libmysqlclient)

if(MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY)
    target_include_directories(sword3paysys PRIVATE ${MYSQL_INCLUDE_DIR})
    target_link_libraries(sword3paysys PRIVATE ${MYSQL_LIBRARY})
    target_compile_definitions(sword3paysys PRIVATE HAVE_MYSQL=1)
    message(STATUS "MySQL client enabled: ${MYSQL_LIBRARY}")
else()
    message(FATAL_ERROR "libmysqlclient is required for the MySQL account backend")
endif()
