set -e

TAG_UNIQUE_ID=`git ls-tree HEAD | sha256sum | cut -c-16`

docker build --pull -f Dockerfile.rpi.buster -t cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID . &
docker build --pull -f Dockerfile.rpi.bullseye -t cgutman/moonlight-embedded-packaging:rpi-bullseye_$TAG_UNIQUE_ID . &
docker build --pull -f Dockerfile.rpi.bullseye64 -t cgutman/moonlight-embedded-packaging:rpi-bullseye64_$TAG_UNIQUE_ID . &
wait

docker push cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi-bullseye_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi-bullseye64_$TAG_UNIQUE_ID
