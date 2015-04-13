#!/bin/sh
set -ex

DIR=`pwd`/`dirname $0`
mkdir -p "$DIR/build"
rm -rf "$DIR/build/*"
find "$DIR" -name *.java -exec javac -cp "$DIR/src" {} \;
cd "$DIR/src"
sh lib/build_lib.sh
find . -name *.class | xargs jar cf "$DIR/build/cocoa4java.jar"
find . -name *.class | xargs rm
