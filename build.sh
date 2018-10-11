# Copyright (C) 2016 Andrew Jiang (TunnelBear Inc.)
# Convenience script for generating shapeshifter-dispatcher binaries for Android devices

if [ "$1" == "clean" ]; then
        echo "Cleaning up..."
        for folder in /tmp/android-toolchain-*; do
                if [[ -d $folder ]]; then
                        rm -rf $folder
                fi
        done
        if [[ -d "./out" ]]; then
                rm -rf ./out
        fi
        echo "Done!"
else
        if [ -z $NDK ]; then
                echo "Android NDK path not specified!"
                echo "Please set \$NDK before starting this script!"
                return 1;
        fi

        # Our targets are x86, x86_64, armeabi, armeabi-v7a, armv8;
        # To remove targets, simply delete them from the bracket.
        # NOTE: We are only currently shipping the armeabi-v7a binary
        # on Android, for space reasons.
        targets=(386 amd64 armv5 armv7 arm64)
        export GOOS=android

        for arch in ${targets[@]}; do
                # Initialize variables
                go_arch=$arch
                ndk_arch=$arch
                ndk_platform="android-14"
                suffix=$arch
                export CGO_ENABLED=1

                if [ "$arch" = "386" ]; then
                        ndk_arch="x86"
                        suffix="x86"
                        binary="i686-linux-android-clang"
                elif [ "$arch" = "amd64" ]; then
                        ndk_platform="android-21"
                        ndk_arch="x86_64"
                        suffix="x86_64"
                        binary="x86_64-linux-android-clang"
                elif [ "$arch" = "armv5" ]; then
                        export GOARM=5
                        go_arch="arm"
                        ndk_arch="arm"
                        suffix="armeabi"
                        binary="arm-linux-androideabi-clang"
                elif [ "$arch" = "armv7" ]; then
                        export GOARM=7
                        go_arch="arm"
                        ndk_arch="arm"
                        suffix="armeabi-v7a"
                        binary="arm-linux-androideabi-clang"
                elif [ "$arch" = "arm64" ]; then
                        suffix="arm64-v8a"
                        ndk_platform="android-21"
                        binary="aarch64-linux-android-clang"
                elif [ "$arch" = "mips" ]; then
                        binary="mipsel-linux-android-clang"
                fi

                export GOARCH=${go_arch}
                export NDK_TOOLCHAIN=/tmp/android-toolchain-${ndk_arch}

                # Only generate toolchain if it does not already exist
                if [ ! -d $NDK_TOOLCHAIN ]; then
                        echo "Generating ${suffix} toolchain..."
                        $NDK/build/tools/make-standalone-toolchain.sh \
                        --arch=${ndk_arch} --platform=${ndk_platform} --install-dir=$NDK_TOOLCHAIN
                        if [ $? -eq 0 ]; then
                                echo "Toolchain generated!"
                        else
                                echo "Toolchain generation failed; Bailing."
                                return 1;
                        fi
                fi
                export CC=$NDK_TOOLCHAIN/bin/${binary}

                echo "Starting compilation for $suffix..."
		go get $3
                go build -buildmode=pie -ldflags '-w -s -extldflags=-pie' -o ./out/${suffix}/$2 $3
                if [ $? -eq 0 ]; then
                        echo "Build succeeded!"
                else
                        echo "Build failed; Bailing."
                fi
        done
fi
