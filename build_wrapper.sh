#!/bin/bash
ROOT_DIR=$PWD
cd ${ROOT_DIR}/cpp

# Cpp to lib 静态库文件生成
# g++ -Wall -c person.cpp wrapper.cpp
# ar -rv libwrapper.a *.o
# rm *.o


# 动态库文件生成
g++ -c -fPIC person.cpp wrapper.cpp
# 生成动态库文件 libgotest.so 这里注意linux的库命名规则为 lib{库名称}.so 使用的时候直接  -l{库名称}.so 即可
g++ -shared -fPIC -o libwrapper.so person.o wrapper.o
rm -rf *.o
mv -f libwrapper.so ../libwrapper.so

# 编译并运行wrapper.go
cd ${ROOT_DIR}
go build wrapper.go
./wrapper