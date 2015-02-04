
GO_CROSSCOMPILE_PATH=/home/gopkg/golang-crosscompile
BUILD_OUTPUT=./build

export GOPATH=$BUILD_OUT
source $GO_CROSSCOMPILE_PATH/crosscompile.bash

GOARM=5 go-linux-arm get git.torproject.org/pluggable-transports/meek.git/meek-client
GOARM=5 go-linux-arm get git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
cp $BUILD_OUTPUT/bin/linux_arm/* .
