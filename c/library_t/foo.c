#include <stdio.h>  
#include <dlfcn.h>  
#include "test.h"
/* 
 * dynamic get global variable and function
 * c++ http://www.faqs.org/docs/Linux-mini/C++-dlopen.html
 * could using "nm" check function symbol
 */
void hello_m() {
    printf("hello m\r\n");
}
#define MAX_WORD 168
struct test_dl  dl_test_g = {567,789,'c',hello_m};
int main(int argc, char **argv) {
    void *handle;
    void (*hello_fun)();
    char *error;
    fprintf (stderr, "MAX_WORD:%d \r\n", MAX_WORD);  
    //handle = dlopen (argv[1], RTLD_LAZY);
    handle = dlopen (argv[1], RTLD_NOW | RTLD_GLOBAL);
    //handle = dlopen ("/root/dl/libtest.so", RTLD_LAZY);
    if (!handle) {
        fprintf (stderr, "%s ", dlerror());  
        return 0;
    }

    dlerror();
        
    
    //struct test_dl* object = (struct test_dl*)dlsym(handle, "dl_test_g");
    struct test_dl* object = (struct test_dl*)dlsym(handle, "dl_test_g");
    if ((error = dlerror()) != NULL)  {
        fprintf (stderr, "%s ", error);
        return 0;
    }

    printf("obj:%d %d %c \r\n",object->a,object->b,object->c);
    object->func();

    hello_fun =(void (*)()) dlsym(handle, "hello");
    if ((error = dlerror()) != NULL)  {
        fprintf (stderr, "%s ", error);
        return 0;
    }
    (*hello_fun)();
     
    fprintf (stderr, "MAX_WORD:%d \r\n", MAX_WORD);  

    dlclose(handle);
    return 0;
}  
