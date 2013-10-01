/*
 * File: main.h
 * Date: 28.01.2011
 * Denis Zheleznyakov aka ZiB @ http://ziblog.ru
 */

#ifndef MAIN_H_
#define MAIN_H_

#include "stm8l15x_conf.h"

#include "macros.h"

#include "mcu_gpio.h"

#define PIN_LED_GREEN			E, 7, HIGH, OUTPUT_PUSH_PULL_SPEED_LIMIT_10MHZ
#define PIN_LED_BLUE			C, 7, HIGH, OUTPUT_PUSH_PULL_SPEED_LIMIT_10MHZ
#define PIN_USER_BUTTON			C, 1, LOW, INPUT_PULL_UP_WITHOUT_ITERRUPT

#endif /* MAIN_H_ */
