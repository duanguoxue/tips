#!/bin/bash
# duanguoxue@gmail.com
# gen base function code coverage report
# default open http 8000 port to check report
# requirement : lcov genthml python 
# can use for blade build tools

lcov -b ./ -c -i -d ./ -o .coverage.base
lcov -b ./ -c -d ./ -o .coverage.run
lcov -b ./ -d ./ -a .coverage.base -a .coverage.run -o .coverage.total

genhtml .coverage.total -o html_report
cd html_report && python -m SimpleHTTPServer 8000
