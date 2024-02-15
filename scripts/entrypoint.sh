#!/bin/bash
set -m
export APP_PATH=/opt/app/
cd $APP_PATH

git config --global user.name "Zero"
git config --global user.email "zero.js.dev@gmail.com"
git config --global http.sslVerify false

git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git -b camellia-r-oss camellia-r-oss

pushd camellia-r-oss
    git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
    mkdir out
    export ARCH=arm64
    export SUBARCH=arm64
    export DTC_EXT=dtc
    export CC=clang
    export CLANG_TRIPLE=aarch64-linux-gnu-
    export CROSS_COMPILE=aarch64-linux-android-
    # export CROSS_COMPILE=${PWD}/toolchain/bin/aarch64-linux-android-

    wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/android-13.0.0_r0.130/clang-r416183b.tar.gz
    tar vxzf clang-r416183b.tar.gz

    make O=out camellia_gl_defconfig
    make -j$(nproc --all) O=out 2>&1 | tee kernel.log

    tar -czvf out.tar.gz out
    cp out.tar.gz $APP_PATH/dist/
    chmod -R 777 $APP_PATH/dist/
popd

echo "Done!"
  
# tail -f /dev/null
# fg %1
