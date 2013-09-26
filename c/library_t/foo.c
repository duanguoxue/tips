#include <stdio.h>  
#include <dlfcn.h>  
#include "test.h"
/* 
 * dynamic get global variable and function
 * could using "nm" check function symbol
 */
int main(int argc, char **argv) {
    void *handle;
    void (*hello_fun)();
    char *error;
    handle = dlopen (argv[1], RTLD_LAZY);
    //handle = dlopen ("/root/dl/libtest.so", RTLD_LAZY);
    if (!handle) {
        fprintf (stderr, "%s ", dlerror());  
        return 0;
    }

    dlerror();

    hello_fun = dlsym(handle, "hello");
    if ((error = dlerror()) != NULL)  {
        fprintf (stderr, "%s ", error);
        return 0;
    }
    (*hello_fun)();
     
    struct test_dl* object = (struct test_dl*)dlsym(handle, "dl_test_g");
    if ((error = dlerror()) != NULL)  {
        fprintf (stderr, "%s ", error);
        return 0;
    }

    printf("obj:%d %d %c \r\n",object->a,object->b,object->c);
    object->func();

    dlclose(handle);
    return 0;
}  
