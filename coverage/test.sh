#!/bin/bash

. .unittest
echo "Start to unittest"

g++ $CXXFLAGS -o test_tmp test.cc

#init unit test report
TestInit

./test_tmp

#generate coverage report
GenCoverageReport cover_
rm test_tmp
TestCleanUp

#simple coverage report
cd cover_lcov_unittest;
python -m SimpleHTTPServer 8000;cd ..;

