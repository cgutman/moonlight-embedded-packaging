set -e

cd /opt/rpi-userland
mkdir build
cd build
cmake -DARM64=ON -DLIBRARY_TYPE=STATIC -DVCOS_PTHREADS_BUILD_SHARED=OFF ..
make -j$(nproc)
make install
