set -e

# FIXME: Avoid hardcoding this
VERSION="2.4.11"

# Check out the source
[[ ! -z "$COMMIT" ]] || COMMIT="master"
echo "Checking out $COMMIT"
git clone https://github.com/irtimmer/moonlight-embedded.git
cd moonlight-embedded
git checkout $COMMIT
git log -1
git submodule update --init --recursive

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

# Build the package
debuild -us -uc

# Copy the output to the out directory
cd /opt/build
shopt -s extglob
cp -v -r !(moonlight-embedded-$VERSION) /out

# Done!
echo "Build successful!"
