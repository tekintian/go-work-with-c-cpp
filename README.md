# Golang调用 c/c++使用示例



# Go语言调用C++语言需要先将c++代码编译生成动态库 .so 或者 静态库.a 后才能调用



## go 调用C代码
非常简单,直接在.go文件的头部使用注释声明c代码即可, 详见
 [go中使用C语言](./c_work_in_go.go)


## go调用C++ 动态库.so/静态库.a

go调用c++代码逻辑关键点在于c代码的入口必须要有 extern "C" 的声明, 这样go才能调用, 如:

- warpper.h
~~~h
#ifdef __cplusplus
extern "C" {
#endif

// 这里定义你的对外暴露的接口方法即可在go中调用
void doSomething();//示例
// .....

#ifdef __cplusplus
}
#endif

#endif
~~~



ps: 静态库 .a 文件生成后可以在go中通过制定库路径直接使用, 如:
~~~go
/*
#cgo CFLAGS: -I${SRCDIR}/cpp
#cgo LDFLAGS: -L${SRCDIR}/cpp -lwrapper -lstdc++
#include <stdio.h>
#include <stdlib.h>
#include "cpp/wrapper.h"
*/
import "C"

~~~

如果是动态库,则在调试的时候需要将库文件.so文件复制到你的程序的运行路径下或者系统的lib库文件中才能被加载,否则无法加载!!


## go C++ 动态库.so生成 go 编译运行
~~~sh
# 同时生成 hello.so 和 wrapper.so 并编译和运行 hello.go  wrapper.go
sh build.sh
Name is Alex, age is 18
Name is Alex, age is 18
New Name is Tekin age is 19
~~~

## c 调用 c++ 动态库生成
~~~sh
# 生成动态库 hello.so
sh build_hello.sh

# 运行 hello.go 测试
go run test.go
~~~

## cpp to lib 动态库包装类 .so 生成

~~~sh
# 生成动态库 wrapper.so
sh build_wrapper.sh
cd ..
go run wrapper.go

~~~

## 参数说明
-fpic  （ pic:position independent code位置无关码）用于编译阶段，产生的代码没有绝对地址，全部用相对地址，满足了共享库的要求，共享库被加载时地址不是固定的。

如果不加-fpic ，那么生成的代码就会与位置有关，当进程使用该.so文件时都需要重定位，且会产生成该文件的副本，每个副本都不同，不同点取决于该文件代码段与数据段所映射内存的位置。


CFLAGS： 指定头文件（.h文件）的路径，如：CFLAGS=-I/usr/include -I/path/include。同样地，安装一个包时会在安装路径下建立一个include目录，当安装过程中出现问题时，试着把以前安装的包的include目录加入到该变量中来。

LDFLAGS：gcc 等编译器会用到的一些优化参数，也可以在里面指定库文件的位置。用法：LDFLAGS=-L/usr/lib -L/path/to/your/lib。每安装一个包都几乎一定的会在安装目录里建立一个lib目录。如果明明安装了某个包，而安装另一个包时，它愣是说找不到，可以抒那个包的lib路径加入的LDFALGS中试一下。


需要注意的是，“-I dir”和“-L dir”都只是指定了路径，而没有指定文件，因此不能在路径中包含文件名。

另外值得详细解释一下的是“-l”选项，它指示Gcc去连接库文件libsunq.so。由于在Linux下的库文件命名时有一个规定：必须以lib三个字母开头。因此在用-l选项指定链接的库文件名时可以省去lib三个字母。也就是说Gcc在对”-lsunq”进行处理时，会自动去链接名为libsunq.so的文件。

告警和出错选项
-Wall	允许发出Gcc提供的所有有用的报警信息



## go c 数据转换
go语言和C语言不同，无法直接通过( *_Ctype_char)的方式进行强制类型转换。

但是可以通过  unsafe.Pointer 进行进行指针类型的转换。

示例如下：
~~~go
var ret C.int = 0
var key string = "1234567811111111"
var inData string = "1111111122222222"

//对应C语言中的void*
var pContext unsafe.Pointer

var nKeynum C.int = 1

//将go语言中的string转换成*C.char类型
var pKey = (C.CString(key))
var nKeyLen = C.uint(len(key))

var pInData = C.CString(inData)
var nInDataLen = C.uint(len(inData))

var pOutData *C.uchar
var pOutDataLen *C.uint

//将*C.char转换成*C.uchar类型
var pKey2 = (*C.uchar)(unsafe.Pointer(pKey))
var pInData2 = (*C.uchar)(unsafe.Pointer(pInData))
~~~

