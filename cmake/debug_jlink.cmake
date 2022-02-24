set(DEBUG_ERASE_CMD "JLinkExe" "-commanderscript" "${CMAKE_CURRENT_SOURCE_DIR}/Erase.jlink")
set(DEBUG_FLASH_CMD "JLinkExe" "-commanderscript" "${CMAKE_CURRENT_SOURCE_DIR}/Flash.jlink")

write_file(${CMAKE_CURRENT_SOURCE_DIR}/Erase.jlink
"device ${MCU_TARGET}
speed 4000
r
erase
r
exit"
)

write_file(${CMAKE_CURRENT_SOURCE_DIR}/Flash.jlink
"device ${MCU_TARGET}
speed 4000
r
loadfile ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.hex
r
g
exit"
)

write_file(${CMAKE_CURRENT_SOURCE_DIR}/.vscode/launch.json
{\n
    \t\"version\": \"0.2.0\",\n
    \t\"configurations\": [\n
    \t{\n
        \t\t\"name\": \"${MCU_TARGET}\",\n
        \t\t\"type\": \"cortex-debug\",\n
        \t\t\"request\": \"launch\",\n
        \t\t\"servertype\":\"jlink\",\n
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