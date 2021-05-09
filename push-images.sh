set -e

TAG_UNIQUE_ID=`git ls-tree HEAD | sha256sum | cut -c-16`

docker build -f Dockerfile.rpi.buster -t cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID .

docker push cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID
