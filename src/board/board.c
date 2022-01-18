/******************************************************************************
Board level init and utility functions
Copyright (c) 2022 ENTITY NAME
board.c
*******************************************************************************/
#include <stdint.h>
#include "board.h"

volatile static uint32_t g_systickCounter; /*! @brief Counter accumulating the systick count value */
volatile static uint32_t g_delayCounter; /*! @brief Delay counter value used to store the current delay value */

/*!
 * @brief SysTick Handler expected to tick every 1ms. Decrementing
 * a global delay counter until it reaches zero and incremnting
 * a global tick counter
 */
void SysTick_Handler(void)
{
    if (g_delayCounter != 0U)
    {
        g_delayCounter--;
    }

    g_systickCounter++;
}

/*!
 * @brief Execute all board specific initialization and setup
 */
void BOARD_Init(void) {
    // Clock init
    // Peripheral Init
}

/*!
 * @brief Delay the specified number of ticks
 */
void BOARD_DelayTicks(uint32_t n)
{
    g_delayCounter = n;
    while (g_delayCounter != 0U)
    {
    }
}

/*!
 * @brief Retrieve the current global tick counter value
 */
uint32_t BOARD_GetTick(void) {
    return g_systickCounter;
}