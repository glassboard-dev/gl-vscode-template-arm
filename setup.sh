#!/bin/bash
# Cleanup any old Cmake artifacts
if [ -d "build" ];then rm -rf build; fi

# Check if a build type was specified. If so, it's a debug build. Otherwise its release.
if [ -z $1 ]
then
    # Generate a makefile for the Debug variant
    echo "Generating Makefile for DEBUG build"
    mkdir -p build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="../arm-gcc-toolchain.cmake" -DCMAKE_BUILD_TYPE=debug ..
else
    # Generate a makefile for the Release variant
    echo "Generating Makefile for RELEASE build"
    mkdir -p build
    cd build
    cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE="../arm-gcc-toolchain.cmake" -DCMAKE_BUILD_TYPE=release ..
fi;

exit 0