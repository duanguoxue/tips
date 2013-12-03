g++ -shared -fPIC -g -o libtest.so test.c
g++ -o  foo foo.c -ldl
./foo `pwd`"/libtest.so"
