#include <stdio.h>
#include <stdint.h>

#define N 12

int main () {
    int32_t arr[N] = {
    0xffffffff, 0x55555555, 0x44444444, 0x11111111,
    0xffffff00, 0x55005555, 0x55444444, 0x11113311,
    0xff00ffff, 0x55550055, 0x44444433, 0x11551111
    };
    int32_t suma = 0;
    int32_t i = 0;
    int32_t n = 12;
    for (i = 0; i < n; i++){
        if ((arr[i] & 0x1) == 0x0) suma += arr[i];
    }
    printf("Suma %08x", suma);
    return 0;
}
