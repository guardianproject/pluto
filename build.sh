#!/bin/sh

#export NDK_TOOLCHAIN=/please/define/this/to/your/ndk

export CC=$NDK_TOOLCHAIN/bin/arm-linux-androideabi-gcc
export THISPATH=`pwd`
export GOROOT=$THISPATH/go-android/go
export GOPATH=$THISPATH
export GOOS=android
export GOARCH=arm
export GOARM=7
export CGO_ENABLED=1
GOGCCFLAGS="$GOGCCFLAGS -fPIE -pie"

GO="$GOROOT/bin/go"

$GO env

##$GO get  --ldflags '-extldflags "-fPIE -pie"' git.torproject.org/pluggable-transports/meek.git/meek-client
$GO get  --ldflags '-extldflags "-fPIE -pie"' github.com/n8fr8/meek/meek-client
$GO get  --ldflags '-extldflags "-fPIE -pie"' git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy 

