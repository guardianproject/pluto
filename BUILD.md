/** Pre-Requisites **/

Setup cross-compilation for go-linux-arm using these instructions:
http://dave.cheney.net/2013/07/09/an-introduction-to-cross-compilation-with-go-1-1

/** How to Build OBFS4 for Android **/

Build obfs4 for Android

GOARM=5 go-linux-arm get git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy

/** How to build Meek for Android **/

Build meek-client:

GOARM=5 go-linux-arm get git.torproject.org/pluggable-transports/meek.git/meek-client
