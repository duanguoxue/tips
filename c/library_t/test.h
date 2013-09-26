#ifndef TEST_H
#define TEST_H

typedef void (*hello_t)();
struct test_dl{
    int a;
    int b;
    char c;
    hello_t func;
};

void hello();
#endif

