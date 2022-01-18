/******************************************************************************
Header file for application version and debug/release flag
Copyright (c) 2022 ENTITY NAME
version.h
*******************************************************************************/

#ifndef _VERSION_H_
#define _VERSION_H_

// https://semver.org/
#define VERSION_MAJOR   0 /*! @brief Major Version Number */
#define VERSION_MINOR   1 /*! @brief Minor Version Number */
#define VERSION_PATCH   0 /*! @brief Patch Version Number */

// If applicable a DEBUG version can be used
#ifdef DEBUG_BUILD
    #define VERSION_DEBUG   1 /*! @brief Debug Version */
#else
    #define VERSION_DEBUG   0 /*! @brief NON Debug Version */
#endif

#endif // _VERSION_H_