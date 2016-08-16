#!/bin/sh

rm -rf pgps pgkill
cd ..
export PERL5LIB=`pwd`/lib:$PERL5LIB

fatpack pack bin/pgps > fat/pgps
chmod +x fat/pgps
fatpack pack bin/pgkill > fat/pgkill
chmod +x fat/pgkill

rm -rf fatlib
