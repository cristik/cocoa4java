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

import com.cristik.cocoa4java.WindowCapture;
import com.cristik.cocoa4java.WindowInfo;
import java.io.FileOutputStream;

public class WindowCaptureTest {

    /**
      * Uses the first command line argument as PID to fetch the windows from,
      * and saves a snapshot of all found windows into the Pictures folder.
      * Snapshots are saved under the <window_number>_<proces_name>_<window_title>.png format
      */
    public static void main(String []args){
        
        if(args.length == 0) {
            System.out.println("Usage: WindowCaptureTest <pid>");
            return;
        }
        int pid = Integer.parseInt(args[0]);
        WindowInfo[] windowInfos = WindowCapture.findWindowsForPID(pid);
        System.out.println("windowInfos count: "+windowInfos.length);
        for(WindowInfo windowInfo: windowInfos) {
            String path = String.format("%s/Pictures/%d_%s_%s.png",System.getProperty("user.home"),
                    windowInfo.windowNumber, windowInfo.ownerName, windowInfo.title);
            System.out.println("Number: "+windowInfo.windowNumber+"\nTitle:"+windowInfo.title+
                "\nOwnerName: "+windowInfo.ownerName+"\nOwnerPID: "+windowInfo.ownerPID+
                "\nIsOnScreen: "+windowInfo.isOnScreen+"\nWidth: "+windowInfo.width+
                "\nHeight: "+windowInfo.height+"\nSaving snapshot to: "+path);
                        
            try {
                FileOutputStream fos = new FileOutputStream(path);
                byte []snapshot = WindowCapture.getWindowSnapshotData(windowInfo.windowNumber, WindowCapture.IMAGE_FORMAT_PNG);                    
                fos.write(snapshot);
                fos.close();
            }catch(Exception ex) {
                System.out.println("Could not save the snapshot: "+ex);
            }
            System.out.println("\n");
        }
    }
}