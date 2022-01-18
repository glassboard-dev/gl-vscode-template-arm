/******************************************************************************
Standard return code enum
Copyright (c) 2022 ENTITY NAME
error.h
*******************************************************************************/

#ifndef _ERROR_H_
#define _ERROR_H_

/*!
 * @brief Standard App return codes
 */
typedef enum {
    APP_RET_OK          = 0,    /* OK */
    APP_RET_ERROR       = -1,   /* Error */
    APP_RET_BUSY        = -2,   /* Interface Busy */
    APP_RET_TIMEOUT     = -3,   /* Timeout */
    APP_RET_INV_PARAM   = -4,   /* Invalid Parameter */
    APP_RET_NULL_PTR    = -5,   /* NULL Pointer */
} app_return_code_t;

#endif // _ERROR_H_