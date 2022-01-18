### Documentation Style
All of the source files should be commented/documented using Doxygen style comments. This has two benefits: 1.) The code is well documented and more friendly for new developers to come along and understand the code. 2.) VScode can parse these comments and provide hints/tooltips when hovering a mouse over a function, variable or macro name.

#### File Headers
When documenting a File. A ```@file``` keyword is used for the Filename folowed by a ```@brief``` for a quick file description
```c
/*! @file mcp342x.h
 * @brief Public header file for the MCP342x 16-Bit, ADC C driver.
 */
```

#### Variables & Macros
When documenting a variable or macro the comment should be placed on the same line following the definition using the ```@brief``` keyword
```c
#define MCP342x_LSB_VAL (0.0000625) /*! @brief LSB Value in Volts of a sampled output code */
```

#### Typedef Enums, Structs and Unions
When documenting a typedef enum or struct a brief header is placed above the definition to give a description of the Typedef and a single comment is placed on each line of a member.
```c
/*!
 * @brief MCP342x Conversion Modes
 */
typedef enum {
    MCP342x_CM_ONE_SHOT     = 0x00, /* One Shot Conversion */
    MCP342x_CM_CONT         = 0x01, /* Continuous Conversion */
    MCP342x_CM__MAX__       = 0x02, /* Conversion Mode Max */
} mcp342x_conversion_mode_enum;

/*!
 * @brief MCP342x ADC Results
 */
typedef struct
{
    uint16_t outputCode;            /* 16-bit Output Code */
    float voltage;                  /* Sampled Voltage */
} mcp342x_results_t;

/*!
 * @brief MCP342x Configuration Register
 */
typedef union
{
    struct
    {
        uint8_t gain        : 2;    /* Gain */
        uint8_t sample_rate : 2;    /* Sample Rate */
        uint8_t conv_mode   : 1;    /* Conversion Mode */
        uint8_t channel     : 2;    /* Channel */
        uint8_t ready       : 1;    /* Ready Bit */
    } bits;
    uint8_t byte;
} mcp342x_config_t;

```

#### Functions
When documenting a function in your source file (```.c```), you simply need to place a single brief statement. Below is an example of documenting an I2C Read interface
```c
/*!
 * @brief This function pointer API reads I2C data from the specified
 * device on the bus.
 */
int8_t i2c_read(const uint8_t busAddr, uint8_t *data, const uint32_t len) {
    app_return_code_t ret = APP_RET_OK;

    // I2c read function code here

    return ret;
}
```
When documenting the API in your header file (```.h```), the documentation is a bit more involved. Here you will place a brief, as well as defining the parameters and a description of what the return value pertains to. Take note of the ```@param``` variables and their directions (```in/out```). Notice that even though the ```data``` parameter is an input argument, we documented it as an output since we expect the function to manipulate something that the data pointer points to.
```c
/*!
 * @brief This function pointer API reads I2C data from the specified
 * device on the bus.
 *
 * @param[in] busAddr: Address of the device to be read from
 * @param[out] *data: Pointer to the where we should store the read data
 * @param[in] len: Length of data to be read
 *
 * @return The result of reading I2C data
 */
int8_t i2c_read(const uint8_t busAddr, uint8_t *data, const uint32_t len);
```
