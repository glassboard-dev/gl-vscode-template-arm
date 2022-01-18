/******************************************************************************
Board level definitions
Copyright (c) 2022 ENTITY NAME
board.h
*******************************************************************************/

#ifndef _BOARD_H_
#define _BOARD_H_

#include <stdint.h>

/*!
 * @brief Execute all board specific initialization and setup
 */
void BOARD_Init(void);

/*!
 * @brief Delay the specified number of ticks
 * @param[in] n: Number of ticks to delay
 */
void BOARD_DelayTicks(uint32_t n);

/*!
 * @brief Retrieve the current global tick counter value
 * @return Return the current global tick counter
 */
uint32_t BOARD_GetTick(void);

#endif /* _BOARD_H_ */