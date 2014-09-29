rm -f cabal.sandbox.config
rm -rf .cabal-sandbox
cabal sandbox init
cabal install -j gtk2hs-buildtools random-1.0.1.1
cabal install -j --with-gcc=gcc-4.8
