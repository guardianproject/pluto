https://jasonplayne.com/tag/golang

To build for the android platform (GOOS=android) you need to do the following:


1. Get a copy of Golang >= version 1.4 from https://golang.org/dl/
2. Unpack it into ~/dev
3. Grab the latest copy of the Android NDK from https://developer.android.com/tools/sdk/ndk/index.html
4. Make it executable and run it (it unpacks into the current folder, so ~/dev)
5. Time to get a copy of our platform NDK.

> export NDK_TOOLCHAIN=~/dev/ndk-toolchain
> $NDK_TOOLCHAIN/build/tools/make-standalone-toolchain.sh --platform=android-16 --install-dir=$NDK_ROOT --arch=arm

Now we need to build the Golang toolchain, cd into ~/dev/go/src

> export NDK_CC=~/dev/ndk-toolchain/bin/arm-linux-androideabi-gcc
> CC_FOR_TARGET=$NDK_CC GOOS=android GOARCH=arm GOARM=7 ./make.bash
    
Now we can cross compile
You can put the following into a build.sh file

> export NDK_TOOLCHAIN=~/dev/ndk-toolchain
> export CC=$NDK_TOOLCHAIN/bin/arm-linux-androideabi-gcc
> export GOPATH=`pwd`
> export GOROOT=$GOPATH/go-android/go
> export GOOS=android
> export GOARCH=arm
> export GOARM=7
> export CGO_ENABLED=1

> GO="$GOROOT/bin/go"

> $GO build -x main.go
