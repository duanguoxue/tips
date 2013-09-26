#include "test.h"
#include <stdio.h>
void hello() {
    printf("hello \r\n");
}

static void word() {
    printf("word!\r\n");
}

struct test_dl dl_test_g = {123,456,'c',word};
