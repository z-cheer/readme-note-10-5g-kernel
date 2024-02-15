#!/bin/bash
set -m
export APP_PATH=/opt/app/
cd $APP_PATH

git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git -b camellia-r-oss camellia-r-oss

pushd camellia-r-oss
    git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
    mkdir out
    export ARCH=arm64
    export SUBARCH=arm64
    export DTC_EXT=dtc
    export CROSS_COMPILE=${PWD}/toolchain/bin/aarch64-linux-android-

    # wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/android-9.0.0_r48/clang-4691093.tar.gz
    # tar vxzf linux-x86-android-9.0.0_r48-clang-4691093.tar.gz

    make O=out perseus_user_defconfig
    make -j$(nproc) O=out 2>&1 | tee kernel.log

    tar -czvf out.tar.gz out
    cp out.tar.gz $APP_PATH/dist/
    chmod -R 777 $APP_PATH/dist/
popd

echo "Done!"
  
# tail -f /dev/null
# fg %1
