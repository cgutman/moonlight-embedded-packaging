TARGET_NAME="rpi-bullseye64"
DOCKERIMAGE="cgutman/moonlight-embedded-packaging"
DOCKERFILE="Dockerfile.rpi.bullseye64"

TAG_UNIQUE_ID=`git ls-tree HEAD | sha256sum | cut -c-16`
TAG_NAME="${TARGET_NAME}_${TAG_UNIQUE_ID}"
OUT_DIR="out_$TARGET_NAME"

docker pull $DOCKERIMAGE:$TAG_NAME
PULL_EXIT_CODE=$?

rm -rf $OUT_DIR

set -e
mkdir $OUT_DIR

if [ $PULL_EXIT_CODE -eq 0 ]; then
  echo Using pre-built Docker image - $DOCKERIMAGE:$TAG_NAME
else
  echo Pre-built image not available - building $DOCKERIMAGE:$TAG_NAME
  docker build -f $DOCKERFILE -t $DOCKERIMAGE:$TAG_NAME .
  echo Built Docker image - $DOCKERIMAGE:$TAG_NAME
fi

docker run --rm --mount type=bind,source="$(pwd)"/$OUT_DIR,target=/out --mount type=bind,source="$(pwd)"/debian,target=/opt/debian -e COMMIT="$1" $DOCKERIMAGE:$TAG_NAME
