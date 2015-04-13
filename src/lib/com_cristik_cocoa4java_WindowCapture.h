// Copyright (c) 2015, Cristian Kocza
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include <jni.h>
/* Header for class com_cristik_cocoa4java_WindowCapture */

#ifndef _Included_com_cristik_cocoa4java_WindowCapture
#define _Included_com_cristik_cocoa4java_WindowCapture
#ifdef __cplusplus
extern "C" {
#endif
#undef com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_PNG
#define com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_PNG 1L
#undef com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_JPEG
#define com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_JPEG 2L
#undef com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_TIFF
#define com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_TIFF 3L
/*
 * Class:     com_cristik_cocoa4java_WindowCapture
 * Method:    findWindowsForPID
 * Signature: (I)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_com_cristik_cocoa4java_WindowCapture_findWindowsForPID
  (JNIEnv *, jclass, jint);

/*
 * Class:     com_cristik_cocoa4java_WindowCapture
 * Method:    getWindowSnapshotData
 * Signature: (II)[B
 */
JNIEXPORT jbyteArray JNICALL Java_com_cristik_cocoa4java_WindowCapture_getWindowSnapshotData
  (JNIEnv *, jclass, jint, jint);

#ifdef __cplusplus
}
#endif
#endif
