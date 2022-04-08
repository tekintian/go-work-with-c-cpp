package main

/*
#cgo CFLAGS: -I${SRCDIR}/cpp
#cgo LDFLAGS: -L${SRCDIR}/cpp -lwrapper -lstdc++
#include <stdio.h>
#include <stdlib.h>
#include "cpp/wrapper.h"
*/
import "C"
import (
	"fmt"
)

func main() {
	p := C.call_Person_Create()
	name := C.GoString(C.call_Person_GetName(p))
	age := C.call_Person_GetAge(p)

	// 重新设置对象的name和age
	C.call_Person_SetAge(p, 19)
	C.call_Person_SetName(p, C.CString("Tekin"))

	nameNew := C.GoString(C.call_Person_GetName(p))
	ageNew := C.call_Person_GetAge(p)

	C.call_Person_Destroy(p) //销毁对象

	fmt.Printf("Name is %s, age is %d\nNew Name is %s age is %d \n", name, age, nameNew, ageNew)
}

// 本示例使用 cpp/wrapper.h头文件中定义的方法, 执行 cpp/build_wrapper.sh 即可生成动态库 libwrapper.so
