set -e

# Check out the source
[[ ! -z "$REPO_URL" ]] || REPO_URL="https://github.com/moonlight-stream/moonlight-embedded.git"
[[ ! -z "$COMMIT" ]] || COMMIT="master"
echo "Checking out $COMMIT in $REPO_URL"
git clone $REPO_URL
cd moonlight-embedded
git checkout $COMMIT
git log -1
git submodule update --init --recursive

# Pull the version out of the CMakeLists.txt
VERSION=$(cat CMakeLists.txt | grep project\( | cut -d ' ' -f 3)

# Determine extra distro-specific dependencies
if [ "$TARGET" == "rpi" ] && [ "$DISTRO" == "bullseye" ]; then
   # MMAL is only packaged for 32-bit Bullseye
   EXTRA_BUILD_DEPS="libraspberrypi-dev | rbp-userland-dev-osmc"
   EXTRA_DEPS="libraspberrypi0 | rbp-userland-osmc"
else
   EXTRA_BUILD_DEPS=""
   EXTRA_DEPS=""
fi

# Create a build directory
mkdir /opt/build

# Generate source tarball
/opt/scripts/git-archive-all.sh --format tar.gz /opt/build/moonlight-embedded_$VERSION.orig.tar.gz

# Extract the tarball into the appropriate directory
cd /opt/build
mkdir moonlight-embedded-$VERSION
cd moonlight-embedded-$VERSION
tar xvf ../moonlight-embedded_$VERSION.orig.tar.gz

# Copy the debian directory into the build directory
cp -r /opt/debian .

# Patch the control file with target-specific dependencies
sed -i "s/EXTRA_BUILD_DEPS/$EXTRA_BUILD_DEPS/g" debian/control
sed -i "s/EXTRA_DEPS/$EXTRA_DEPS/g" debian/control
cat debian/control

# Build the package
debuild -us -uc

# Copy the output to the out directory
cd /opt/build
shopt -s extglob
cp -v -r !(moonlight-embedded-$VERSION) /out

# Done!
echo "Build successful!"
