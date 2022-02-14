# Set our minimum required CMake Version
cmake_minimum_required(VERSION 3.13)

#####################################################################################
# Set our project and CPU specific flags, options, definitions and Linker Settings
#####################################################################################
# Project name
set(PROJECT_NAME "NEW_PROJECT")
# Desired executable name
set(EXECUTABLE_NAME ${PROJECT_NAME})
# MCU Target name as seen in PyOCD
set(PYOCD_MCU_TARGET MY_PN)

# Set our specific CPU compiler flags
set(COMPILER_CPU_FLAGS "-mcpu=cortex-m33 -mfloat-abi=hard -mfpu=fpv5-sp-d16")

# Set any libraries you would need to link against (.a libs, gcc, c, m, nosys as examples)
# NOT TO BE CONFUSED WITH LINKER FLAGS. FLAGS BELONG IN the flags.cmake file
set(LINKER_STATIC_LIBRARIES
)

# Specify the location of our Linker file
set(CPU_LINKER_FILE ${CMAKE_CURRENT_SOURCE_DIR}/src/board/LINKER_FILE.ld)

# Set debug build specific definitions
set(DEBUG_BUILD_DEFINITIONS -DDEBUG_BUILD)
# Set release build specific definitions
set(RELEASE_BUILD_DEFINITIONS -DRELEASE_BUILD)

# Create a list of our APP source
set(APP_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/main.c
            ${CMAKE_CURRENT_SOURCE_DIR}/src/board/board.c
)

# Glob together a list of our SDK source
FILE(GLOB SDK_SRC
            # ${CMAKE_CURRENT_SOURCE_DIR}/vendor/MANUF/src/*.c
)

# Set all of our application and SDK include paths
set(INCLUDE_DIRS    ${CMAKE_CURRENT_SOURCE_DIR}/src/
                    ${CMAKE_CURRENT_SOURCE_DIR}/src/board
)

# Add any subdirectories with CMake projects that should be added
set(CMAKE_SUBDIRS
    # ${CMAKE_CURRENT_SOURCE_DIR}/vendor/glasslabs/DAC757x
)

#####################################################################################
# End of project and CPU specific items - DO NOT EDIT ANYTING BELOW THIS POINT
#####################################################################################

# ENABLE ASM
ENABLE_LANGUAGE(ASM)

# Include our flags for compilation and linking
include(${CMAKE_CURRENT_SOURCE_DIR}/flags.cmake)

# Set the project name and desired Language - This will set he base output executable name
project(${PROJECT_NAME} VERSION 1.0 LANGUAGES C)

# Set the C standard and executable suffix
set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Set our executable output path to the 'output/' folder
SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/output/${CMAKE_BUILD_TYPE})
SET(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/output/${CMAKE_BUILD_TYPE})

# Include the specified paths
include_directories(${INCLUDE_DIRS})

# Generate our executable using the app/sdk source and includes
add_executable(${EXECUTABLE_NAME}
    ${APP_SRC}
    ${SDK_SRC}
)

# Link against any specificed libs
target_link_libraries(${EXECUTABLE_NAME} PRIVATE ${LINKER_STATIC_LIBRARIES})

# Append our CPU specific flags to our Compiler and Linker flags
set(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} ${COMPILER_CPU_FLAGS}")
set(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} ${COMPILER_CPU_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${COMPILER_CPU_FLAGS}")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${COMPILER_CPU_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${COMPILER_CPU_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} ${COMPILER_CPU_FLAGS}")

# Add in our build specific compile definitions/macros
if(CMAKE_BUILD_TYPE STREQUAL debug)
    target_compile_definitions(${EXECUTABLE_NAME} PUBLIC ${DEBUG_BUILD_DEFINITIONS})
endif()

if(CMAKE_BUILD_TYPE STREQUAL release)
    target_compile_definitions(${EXECUTABLE_NAME} PUBLIC ${RELEASE_BUILD_DEFINITIONS})
endif()

# Add all of our CMake Subdirectories
foreach(subdir ${CMAKE_SUBDIRS})
    add_subdirectory(${subdir})
endforeach()

# Extract the current firmware version
file(READ ${CMAKE_CURRENT_SOURCE_DIR}/src/version.h ver)
# Major
string(REGEX MATCH "VERSION_MAJOR([ \t]+[0-9]*)" _ ${ver})
string(REPLACE " " "" ver_major ${CMAKE_MATCH_1})
# Minor
string(REGEX MATCH "VERSION_MINOR([ \t]+[0-9]*)" _ ${ver})
string(REPLACE " " "" ver_minor ${CMAKE_MATCH_1})
# Patch
string(REGEX MATCH "VERSION_PATCH([ \t]+[0-9]*)" _ ${ver})
string(REPLACE " " "" ver_patch ${CMAKE_MATCH_1})
# Set the final firmware version string
set(firmware_version "v${ver_major}_${ver_minor}_${ver_patch}")

# Convert the elf into an intel hex file
add_custom_target(elfToHex ALL ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}-${CMAKE_BUILD_TYPE}-${firmware_version}.hex DEPENDS ${EXECUTABLE_NAME})

# Convert the elf into a binary file
add_custom_target(elfToBin ALL ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}-${CMAKE_BUILD_TYPE}-${firmware_version}.bin DEPENDS elfToHex)

# Calculate and print the memory sizes / usage
add_custom_target(size ALL ${CMAKE_SIZE_UTIL} ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf DEPENDS elfToBin)

# Add a makefile "target" to erase our part
add_custom_target(erase pyocd erase -t ${PYOCD_MCU_TARGET} --chip)

# Add a makefile "target" to flash the micro
add_custom_target(flash pyocd flash -t ${PYOCD_MCU_TARGET} -f 20000khz ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf)

# Add a makefile "target" for running unit tests
add_custom_target(test cd ../ && ceedling gcov:all utils:gcov)