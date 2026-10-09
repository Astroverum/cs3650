/* Complete the C version of the driver program for mystery. This C code does
 * not need to compile. */

#include <stdio.h>
#include <stdlib.h>

extern long crunch(long, long);

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("Two arguments required.\n");
        return 1;
    }

    long result, arg1, arg2;

    arg1 = strtol(argv[1], NULL, 10);
    arg2 = strtol(argv[2], NULL, 10);
    result = crunch(arg1, arg2);

    if (result < 0) {
        printf("hat\n");
    } else if (result > 0) {
        printf("beer\n");
    } else {
        printf("tea\n");
    }

    return 0;
}