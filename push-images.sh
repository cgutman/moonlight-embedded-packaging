set -e

TAG_UNIQUE_ID=`git ls-tree HEAD | sha256sum | cut -c-16`

docker build --pull -f Dockerfile.rpi.buster -t cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID . &
docker build --pull -f Dockerfile.rpi.bullseye -t cgutman/moonlight-embedded-packaging:rpi-bullseye_$TAG_UNIQUE_ID . &
docker build --pull -f Dockerfile.rpi64.bullseye -t cgutman/moonlight-embedded-packaging:rpi64-bullseye_$TAG_UNIQUE_ID . &
docker build --pull -f Dockerfile.rpi.bookworm -t cgutman/moonlight-embedded-packaging:rpi-bookworm_$TAG_UNIQUE_ID . &
docker build --pull -f Dockerfile.rpi64.bookworm -t cgutman/moonlight-embedded-packaging:rpi64-bookworm_$TAG_UNIQUE_ID . &
wait

docker push cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi-bullseye_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi64-bullseye_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi-bookworm_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi64-bookworm_$TAG_UNIQUE_ID
