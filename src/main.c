/******************************************************************************
Main program entry point
Copyright (c) 2022 ENTITY NAME
main.c
*******************************************************************************/

#include <stdio.h>
#include "error.h"
#include "board.h"

void main(void) {
    app_return_code_t ret = APP_RET_OK;

    // Initialze the board peripherals
    BOARD_Init();

    // Other init code

    // Start running the application code
    while(1) {
        BOARD_DelayTicks(1000);
    }
}