#include "test.h"
#include <stdio.h>
#define MAX_WORD 7777
void hello() {
    printf("hello %d \r\n", MAX_WORD);
}

static void word() {
    printf("word!\r\n");
}

extern "C" {
    struct test_dl dl_test_g = {123,456,'c',word};
}
