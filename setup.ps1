# Cleanup any old Cmake artifacts
if( Test-Path -Path './build' ) {Remove-Item './build' -Recurse}

# Store the build type
$buildType=$args[0];

if( $buildType -eq $null ) {
    Write-Output "Generating Makefile for DEBUG build"
    New-Item -Path './build' -ItemType Directory
    Set-Location './build'
    cmake -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE="../arm-gcc-toolchain.cmake" -DCMAKE_BUILD_TYPE=debug ..
}
else {
    Write-Output "Generating Makefile for RELEASE build"
    New-Item -Path './build' -ItemType Directory
    Set-Location './build'
    cmake -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE="../arm-gcc-toolchain.cmake" -DCMAKE_BUILD_TYPE=release ..
}

exit 0