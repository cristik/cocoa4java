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

#import "com_cristik_cocoa4java_WindowCapture.h"
#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>

BOOL jsetIntField(JNIEnv *jenv, jclass jcls, jobject jobj, const char *fieldName, int value) {
    jfieldID jfieldId = (*jenv)->GetFieldID(jenv, jcls, fieldName, "I");
    if(!jfieldId) return NO;
    (*jenv)->SetIntField(jenv, jobj, jfieldId, value);
    return YES;
}

BOOL jsetBooleanField(JNIEnv *jenv, jclass jcls, jobject jobj, const char *fieldName, BOOL value) {
    jfieldID jfieldId = (*jenv)->GetFieldID(jenv, jcls, fieldName, "Z");
    if(!jfieldId) return NO;
    (*jenv)->SetIntField(jenv, jobj, jfieldId, value);
    return YES;
}

BOOL jsetStringField(JNIEnv *jenv, jclass jcls, jobject jobj, const char *fieldName, const char *value) {
    jfieldID jfieldId = (*jenv)->GetFieldID(jenv, jcls, fieldName, "Ljava/lang/String;");
    if(!jfieldId) return NO;
    if(value) {
        (*jenv)->SetObjectField(jenv, jobj, jfieldId, (*jenv)->NewStringUTF(jenv, value));
    } else {
        (*jenv)->SetObjectField(jenv, jobj, jfieldId, NULL);
    }
    return YES;
}

JNIEXPORT jstring JNICALL Java_com_cristik_cocoa4java_WindowCapture_findWindowsForPID
  (JNIEnv *jenv, jclass jcls, jint pid) {
      @autoreleasepool {
          NSArray *windowInfos = (__bridge_transfer NSArray*)CGWindowListCopyWindowInfo(kCGWindowListOptionAll, kCGNullWindowID);    
        NSUInteger i, count = 0;

        // first we calculate how many windows match the give PID, in order to know how
        // much to allocate for the java array
        for(NSDictionary *windowInfo in windowInfos) {
            if(pid == -1 || [windowInfo[(__bridge NSString*)kCGWindowOwnerPID] unsignedIntValue] == pid) {
                count++;
            }
        }

        jclass jwindowInfoClass = (*jenv)->FindClass(jenv, "com/cristik/cocoa4java/WindowInfo");
        jmethodID jwindowInfoConstructor = (*jenv)->GetMethodID(jenv, jwindowInfoClass, "<init>", "()V");
        jobjectArray jresult = (*jenv)->NewObjectArray(jenv, count, jwindowInfoClass, NULL);
        i = 0;
        for(NSDictionary *windowInfo in windowInfos) {
            if(pid != -1 && 
                [windowInfo[(__bridge NSString*)kCGWindowOwnerPID] unsignedIntValue] != pid) 
                continue;

            jobject jwindowInfo = (*jenv)->NewObject(jenv, jwindowInfoClass, jwindowInfoConstructor);

            jsetIntField(jenv, jwindowInfoClass, jwindowInfo, "windowNumber", 
                [windowInfo[(__bridge NSString*)kCGWindowNumber] intValue]);

            jsetStringField(jenv, jwindowInfoClass, jwindowInfo, "title", 
                [windowInfo[(__bridge NSString*)kCGWindowName] UTF8String]);
            
            jsetStringField(jenv, jwindowInfoClass, jwindowInfo, "ownerName", 
                [windowInfo[(__bridge NSString*)kCGWindowOwnerName] UTF8String]);

            jsetIntField(jenv, jwindowInfoClass, jwindowInfo, "ownerPID", 
                [windowInfo[(__bridge NSString*)kCGWindowOwnerPID] intValue]);
            
            jsetBooleanField(jenv, jwindowInfoClass, jwindowInfo, "isOnScreen", 
                [windowInfo[(__bridge NSString*)kCGWindowIsOnscreen] boolValue]);
            
            NSDictionary *bounds = windowInfo[(__bridge NSString*)kCGWindowBounds];
            jsetIntField(jenv, jwindowInfoClass, jwindowInfo, "width", 
                [bounds[@"Width"] intValue]);
            jsetIntField(jenv, jwindowInfoClass, jwindowInfo, "height", 
                [bounds[@"Height"] intValue]);
            
            (*jenv)->SetObjectArrayElement(jenv, jresult, i++, jwindowInfo);
        }
        return jresult;
    }
    
}

JNIEXPORT jbyteArray JNICALL Java_com_cristik_cocoa4java_WindowCapture_getWindowSnapshotData
  (JNIEnv *jenv, jclass jcls, jint windowId, jint format) {
      @autoreleasepool {
          CGImageRef img = CGWindowListCreateImage(CGRectNull, kCGWindowListOptionIncludingWindow, windowId, kCGWindowImageDefault);
          NSMutableData *imgData = [[NSMutableData alloc] init];
          CFStringRef imgFormat = kUTTypeJPEG;
          switch(format) {
              case com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_PNG:
                  imgFormat = kUTTypePNG; break;
              case com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_JPEG:
                  imgFormat = kUTTypeJPEG; break;
            case com_cristik_cocoa4java_WindowCapture_IMAGE_FORMAT_TIFF:
                  imgFormat = kUTTypeTIFF; break;
          }
        CGImageDestinationRef imgDest = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)imgData, imgFormat, 1, NULL);
        CGImageDestinationAddImage(imgDest, img, NULL);
        BOOL finalizeRes = CGImageDestinationFinalize(imgDest);
        if(!finalizeRes) return NULL;
        jbyteArray res = (*jenv)->NewByteArray(jenv, imgData.length);
        (*jenv)->SetByteArrayRegion (jenv, res, 0, imgData.length, imgData.bytes);
        return res;
      }
}
