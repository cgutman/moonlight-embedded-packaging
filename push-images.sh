fail()
{
	echo "$1" 1>&2
	exit 1
}

git diff-index --quiet HEAD -- || fail "Images must not be pushed with uncommitted changes!"

set -e

TAG_UNIQUE_ID=`git ls-tree HEAD | sha256sum | cut -c-16`

./build-image.sh rpi buster $TAG_UNIQUE_ID &
./build-image.sh rpi bullseye $TAG_UNIQUE_ID &
./build-image.sh rpi64 bullseye $TAG_UNIQUE_ID &
./build-image.sh rpi bookworm $TAG_UNIQUE_ID &
./build-image.sh rpi64 bookworm $TAG_UNIQUE_ID &
wait

docker push cgutman/moonlight-embedded-packaging:rpi-buster_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi-bullseye_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi64-bullseye_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi-bookworm_$TAG_UNIQUE_ID
docker push cgutman/moonlight-embedded-packaging:rpi64-bookworm_$TAG_UNIQUE_ID
