set -e

CMAKE_ARGS="-DLIBRARY_TYPE=STATIC -DVCOS_PTHREADS_BUILD_SHARED=OFF"

if [ "$TARGET" == "rpi64" ]; then
    CMAKE_ARGS="$CMAKE_ARGS -DARM64=ON"
else
    CMAKE_ARGS="$CMAKE_ARGS -DARM64=OFF"
fi

cd /opt/rpi-userland
mkdir build
cd build
cmake $CMAKE_ARGS ..
make -j$(nproc)
make install
