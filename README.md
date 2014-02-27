常用脚本及代码片段
====

c/library_t 
----
测试c dlopen 调用动态库，获取全局对象地址（全局变量），非函数地址

dot/mongo-cxx.dot
----
使用mongodb c++ 驱动过程中用 graphviz dot 画的driver类图

tcl/ssh_exp.tcl
----
tcl 脚本实现的一个 在远程机器执行命令的脚本，需要明文输入ssh密码，可以用户远程机器控制使用（远程控制测试机器）

shell/gstack 
----
pstack 加强版本，由于pstack 过滤代码行，运行中抓取程序的运行堆栈，输出到文件，包含代码行等 
shell/ssh.exp
----
expect 直接ssh到远程机器，功能与 sshpass相同，配置ssh密码内网不考虑安全性，一键远程ssh 

shell/bash_socket.sh
----
bash socket example

screen
----
screen 配置文件 配置使用caption

coverage
----
coverage c++ 通过lcov genhtml 生成html测试报告
