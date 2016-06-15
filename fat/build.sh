#!/bin/sh

rm -rf pgps
cd ..
export PERL5LIB=`pwd`/lib:$PERL5LIB
fatpack pack bin/pgps > fat/pgps
chmod +x fat/pgps
rm -rf fatlib
