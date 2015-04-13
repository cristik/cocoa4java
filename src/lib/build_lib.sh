#!/bin/sh -ex
set -ex

DIR=`dirname $0`
BUILD_DIR=$DIR/../../build
clang -I/System/Library/Frameworks/JavaVM.framework/Headers -framework CoreGraphics -framework ImageIO -framework CoreServices -fobjc-arc -shared -o "$BUILD_DIR/libcocoa4java.dylib" "$DIR/"*.m
