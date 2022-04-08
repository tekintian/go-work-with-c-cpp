#!/bin/bash
# 生成 hello 和 wrapper
ROOT_DIR=$PWD
sh ./build_hello.sh
cd ${ROOT_DIR}
sh ./build_wrapper.sh