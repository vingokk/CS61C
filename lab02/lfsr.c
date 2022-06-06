#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    uint16_t bitAfterXor = (*reg >> 0 & 1) ^ (*reg >> 2 & 1) ^ (*reg >> 3 & 1) ^ (*reg >> 5 & 1);
    *reg = *reg >> 1;
    *reg = (*reg & (~(1 << 15))) | (bitAfterXor << 15);
}
