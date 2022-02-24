# VSCode ARM M-Core Project Template
At first clone, you should ensure that you have all of the tools installed for your OS as detailed in the Software section of the [README_TEMPLATE](./README_TEMPLATE.md) file. After initially cloning this repo, run through each folder/file and ensure the following tasks are completed.
## New repo checklist
- [ ] **doc**
    - [ ] Place any relevant reference material (Reference manuals/data sheets) in the ```doc``` folder
- [ ] **src**
    - [ ] Add any project specific source (written by Glassboard developer) into the src folder using the ```ceedling module:create[FILENAME]``` from the root directory command. This will create the file in the src folder as well as add a new unit test file in the ```test/``` folder
        - [ ] ```ceedling module:create[FILENAME]```
- [ ] **src/version.h**
    - [ ] Set your projects initial Major, Minor and Patch version numbers. You can conditionally use the DEBUG version to indicate a build is release or debug within your application
- [ ] **vendor**
    - [ ] Add project specific submodules and SDKs into the vendor folder
        - [ ] i.e. - If the project uses the Glasslabs AT24Cx submodule. You would create a new folder under ```vendor/glasslabs``` and then add your submodule
        - [ ] ```cd vendor/glasslabs && git submodule add https://github.com/glassboard-dev/AT24Cx```
        - [ ] When adding a staticly downloaded SDK, you would create a new folder under ```vendor/{MICRO_MANUF}``` and then add your SDK files there
- [ ] **project.yml**
    - [ ] Update/add any project specific defines needed for compilation of test cases - This likely includes a macro defining the mico PN (Search for CPU_DEFINE_PN)
        ```yml
        :common: &common_defines
            - CPU_DEFINE_PN
        ```
    - [ ] Update/add any new source paths needed for Vendor and Application source files - Example being a manufacturer provided SDK located at: ```vendor/nxp/SDK/devices/LPC5526/**```
        ```yml
        :paths:
            :source:
                - src/**
- [ ] **cmake/flags.cmake**
    - [ ] Add all of your needed C, C++ and assembly compiler and linker flags for both debug and release variants here. The current file is full of common and usefull flags for most ARM-Core targets
- [ ] **CMakeLists.txt**
    - [ ] Update the CMake variables for your specific project, MCU, sources, etc. All of the user settings that need updating are located at the top of the file. A complete list is below. DO NOT EDIT ANYTHING BELOW THESE CONFIGURATION VARIABLES - If a gap or issue is found, please report back [here](https://github.com/glassboard-dev/gl-arm-vscode-template/issues) so accomodations can be made for the missing config.
        - [ ] PROJECT_NAME
        - [ ] EXECUTABLE_NAME
        - [ ] DEBUG_TOOLSET
        - [ ] ENABLE_SEGGER_RTT
        - [ ] MCU_TARGET
        - [ ] COMPILER_CPU_FLAGS
        - [ ] LINKER_STATIC_LIBRARIES
        - [ ] CPU_LINKER_FILE
        - [ ] DEBUG_BUILD_DEFINITIONS
        - [ ] RELEASE_BUILD_DEFINITIONS
        - [ ] APP_SRC
        - [ ] SDK_SRC
        - [ ] INCLUDE_DIRS
        - [ ] CMAKE_SUBDIRS
- [ ] **README_TEMPLATE**
    - [ ] Update the PROJECT_NAME in the header to your project name
    - [ ] Add project specific software or hardware setup instructions

## When complete with checklist
- [ ] Remove this README and rename the README_TEMPLATE to README to replace this checklist.
    - [ ] ```mv README_TEMPLATE.md README.md```
