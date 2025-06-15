# AOSP Clang & gcc linaro installer script
sudo apt update
sudo apt -y upgrade
sudo apt install -y flex
mkdir clang
cd clang
wget https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main/clang-r547379.tar.gz
tar -xvf *.gz
rm -rf *.tar.gz

cd ..
wget https://snapshots.linaro.org/gnu-toolchain/13.0-2022.10-1/aarch64-linux-gnu/gcc-linaro-13.0.0-2022.10-x86_64_aarch64-linux-gnu.tar.xz
tar -xf gcc-linaro-13.0.0-2022.10-x86_64_aarch64-linux-gnu.tar.xz
rm -rf gcc-linaro-13.0.0-2022.10-x86_64_aarch64-linux-gnu.tar.xz