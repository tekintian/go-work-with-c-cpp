package main

/*
#cgo CFLAGS: -I${SRCDIR}/cpp
#cgo LDFLAGS: -L${SRCDIR}/cpp -lhello -lstdc++
#include <stdio.h>
#include <stdlib.h>
#include "cpp/hello.h"
*/
import "C"
import (
	"fmt"
)

func main() {
	// c to cpp 调用hello.h中的定义方法
	p := C.Create()
	name := C.GoString(C.GetName(p))
	age := C.GetAge(p)
	C.Destroy(p)
	fmt.Printf("Name is %s, age is %d\n", name, age)
}

// 本示例使用 cpp/hello.h头文件中定义的方法, 执行 cpp/build.sh 即可生成动态库 libhello.a  这里的文件后缀 .a 或者 .so都可以
