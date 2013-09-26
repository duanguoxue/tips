gcc -shared -fPIC -g -o libtest.so test.c
gcc -o foo foo.c -ldl
./foo `pwd`"/libtest.so"
