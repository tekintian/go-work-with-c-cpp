#!/bin/bash
ROOT_DIR=$PWD
cd ${ROOT_DIR}/cpp
# C call cpp
# g++ -Wall -c person.cpp wrapper.cpp
# gcc -Wall -c hello.c
# g++ -o test *.o
# rm *.o

# Cpp to lib
# g++ -Wall -c person.cpp wrapper.cpp
# ar -rv libwrapper.a *.o
# rm *.o
#gcc -Wall -c hello.c
#g++ -o test *.o -L. -lhello
#rm *.o

# All to lib  静态库文件生成
# g++ -Wall -c person.cpp wrapper.cpp
# gcc -Wall -c hello.c
# # ar -crv libhello.a *.o
# ar -crsv libhello.a *.o
# rm *.o

# 动态库文件生成
g++ -c -fPIC person.cpp wrapper.cpp
# 这里的hello.c为c文件,所以需要使用gcc来编译 .o文件
gcc -Wall -c hello.c
# 生成动态库文件 libgotest.so 这里注意linux的库命名规则为 lib{库名称}.so 使用的时候直接  -l{库名称}.so 即可
g++ -shared -fPIC -o libhello.so  person.o wrapper.o hello.o
rm -rf *.o
mv -f libhello.so ../libhello.so

# 编译并运行hello
cd ${ROOT_DIR}
go build hello.go
./hello