set(DEBUG_ERASE_CMD "pyocd" "erase" "-t${MCU_TARGET}" "--chip")
set(DEBUG_FLASH_CMD "pyocd" "flash" "-t${MCU_TARGET}" "-f20000khz" "${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf")

write_file(${CMAKE_CURRENT_SOURCE_DIR}/.vscode/launch.json
{\n
    \t\"version\": \"0.2.0\",\n
    \t\"configurations\": [\n
    \t{\n
        \t\t\"name\": \"${MCU_TARGET}\",\n
        \t\t\"type\": \"cortex-debug\",\n
        \t\t\"request\": \"launch\",\n
        \t\t\"servertype\":\"pyocd\",\n
        \t\t\"cwd\": \"${workspaceRoot}\",\n
        \t\t\"executable\": \"${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf\",\n
        \t\t\"device\": \"${MCU_TARGET}\",\n
        \t\t\"runToMain\": true,\n
        \t\t\"v1\": false,\n
        \t\t\"serverArgs\": [\n
            \t\t\t\"--target\",\n
            \t\t\t\"${MCU_TARGET}\"\n
        \t\t]\n
    \t}]\n
})