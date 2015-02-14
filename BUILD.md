# Pre-Requisites

- Go Programming Language 1.4.1: http://golang.org/dl/
- Android NDK: https://developer.android.com/tools/sdk/ndk/index.html 

# How to Build Pluggable Transports for Android **/

1. setup the go-android environment: see go-android/readme.md document
2. run > build.sh script in this folder 

# How to Deply PT's

1. copy binaries from bin/android-arm to desired project
2. Execute binaries form within Android app Runtime.getRuntime().exec() shell
