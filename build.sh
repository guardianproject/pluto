#!/bin/sh

export NDK_TOOLCHAIN=~/dev/android/ndk
export CC=$NDK_TOOLCHAIN/bin/arm-linux-androideabi-gcc
export THISPATH=`pwd`
export GOROOT=$THISPATH/go-android/go
export GOPATH=$THISPATH
export GOOS=android
export GOARCH=arm
export GOARM=7
export CGO_ENABLED=1

GO="$GOROOT/bin/go"

$GO get git.torproject.org/pluggable-transports/meek.git/meek-client

$GO get git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
