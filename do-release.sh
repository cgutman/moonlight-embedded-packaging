fail()
{
	echo "$1" 1>&2
	exit 1
}

git diff-index --quiet HEAD -- || fail "Release builds must not have unstaged changes!"

set -e

# Ensure build images are pushed to DockerHub
./push-images.sh

# Build the packages
./build-single.sh rpi bullseye $1 &
./build-single.sh rpi64 bullseye $1 &
./build-single.sh rpi bookworm $1 &
wait
./build-single.sh rpi64 bookworm $1 &
./build-single.sh rpi trixie $1 &
./build-single.sh rpi64 trixie $1 &
wait

# Push the moonlight-embedded packages to Cloudsmith repos
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bullseye out_rpi-bullseye/moonlight-embedded_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bullseye out_rpi64-bullseye/moonlight-embedded_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bookworm out_rpi-bookworm/moonlight-embedded_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bookworm out_rpi64-bookworm/moonlight-embedded_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/trixie out_rpi-trixie/moonlight-embedded_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/trixie out_rpi64-trixie/moonlight-embedded_*.deb

# Push the moonlight-embedded-dbgsym packages to Cloudsmith repos
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bullseye out_rpi-bullseye/moonlight-embedded-dbgsym_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bullseye out_rpi64-bullseye/moonlight-embedded-dbgsym_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bookworm out_rpi-bookworm/moonlight-embedded-dbgsym_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/bookworm out_rpi64-bookworm/moonlight-embedded-dbgsym_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/trixie out_rpi-trixie/moonlight-embedded-dbgsym_*.deb
cloudsmith push deb moonlight-game-streaming/moonlight-embedded/raspbian/trixie out_rpi64-trixie/moonlight-embedded-dbgsym_*.deb
