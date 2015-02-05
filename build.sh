
export GO_CROSSCOMPILE_PATH=~/gopkg/golang-crosscompile
export BUILD_OUTPUT=/tmp/build

export GOPATH=$BUILD_OUTPUT
source $GO_CROSSCOMPILE_PATH/crosscompile.bash

GOARM=5 go-linux-arm get git.torproject.org/pluggable-transports/meek.git/meek-client
cp $BUILD_OUTPUT/bin/linux_arm/meek* plugins/meek/assets 

GOARM=5 go-linux-arm get git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
cp $BUILD_OUTPUT/bin/linux_arm/obfs* plugins/obfs4/assets 
