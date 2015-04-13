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

package com.cristik.cocoa4java;
import java.util.List;
import java.util.Map;

public class WindowCapture {
    public static final int IMAGE_FORMAT_PNG = 1;
    public static final int IMAGE_FORMAT_JPEG = 2;
    public static final int IMAGE_FORMAT_TIFF = 3;

    /**
      *  Returns a json encoded dictionary with information about the windows
      *  corresponding to the given PID. Pass -1 to obtain all windows in system
      */
    public native static WindowInfo[] findWindowsForPID(int pid);

    /**
      * Takes a snapshot of the provided window id and returns the data
      * The format parameter needs to have one of the IMAGE_FORMAT_XXX consts declared
      * above, otherwise the function will default to the jpg format.
      */
    public native static byte[] getWindowSnapshotData(int windowId, int format);

    static {
        System.loadLibrary("cocoa4java");
    }
}
