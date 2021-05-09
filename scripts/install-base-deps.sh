set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl g++ make devscripts fakeroot debhelper git nasm libssl-dev libopus-dev libasound2-dev libudev-dev libavahi-client-dev libcurl4-openssl-dev libevdev-dev libexpat1-dev libpulse-dev uuid-dev libenet-dev libcec-dev cmake quilt
