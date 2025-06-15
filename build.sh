# Adding settings from settings.sh
source ../settings.sh

# Start counting the execution time of the script
start_time=$(date +%s)

# Export KBUILD USER & HOST
export KBUILD_BUILD_USER="olzhas0986"
export KBUILD_BUILD_HOST="dev"

# KernelSU-Next
git submodule init
git submodule update

#Compilation
make CC=$(pwd)/clang/bin/clang \
LD=$(pwd)/clang/bin/ld.lld \
NM=$(pwd)/clang/bin/llvm-nm \
AR=$(pwd)/clang/bin/llvm-ar \
OBJCOPY=$(pwd)/clang/bin/llvm-objcopy \
OBJDUMP=$(pwd)/clang/bin/llvm-objdump \
STRIP=$(pwd)/clang/bin/llvm-strip \
CROSS_COMPILE_ARM32=$(pwd)/gcc-linaro-13.0.0-2022.10-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf- \
CROSS_COMPILE=$(pwd)/gcc-linaro-13.0.0-2022.10-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- \
O=out ARCH=arm64 -j$(($(nproc)+1)) $@ 2>&1 | tee build.log

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Общее время выполнения: $elapsed_time секунд"

# Compressing kernel ZIP
cd ..
git clone https://github.com/olzhas0986dev/Anykernel.git -b main
cd kernel_xiaomi_sm8250/out/arch/arm64/boot
cp Image.gz ../../../../../Anykernel
cp dtbo.img ../../../../../Anykernel
mv dtb.img dtb
cp dtb ../../../../../Anykernel
cd ../../../../../Anykernel
7z a -mx9 Pureline-POCOF4.zip
rm -rf Image.gz
rm -rf dtbo.img
rm -rf dtb

# Sending build to TG
curl -s -X POST "https://api.telegram.org/bot$TGTOKEN/sendDocument?chat_id=@Ximipurekernel1" \
    -F document=@"./Pureline-POCOF4.zip" \
    -F caption="testing build. Build number ${BUILD}" \
    -F message_thread_id="3"
    
rm -rf Pureline-POCOF4.zip