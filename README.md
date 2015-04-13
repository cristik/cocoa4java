# cocoa4java

JNI classes to access the Cocoa API.

Currently there's only a WindowCapture class that provides helper methods for retrieving the
windows that belong to a certain process, and for retrieving a snapshot of a given window.

## Build

Run the make.sh file, this will compile the JNI classes and pack them into a cocoa4java jar file.
make.sh will also build a libcocoa4java.dylib dynamic library that will be loaded by the WindowCapture
class. Please make sure that this library resides within java.library.path so that it can be loaded.
The build command outputs the files into the "build" folder.

## Usage

There's a WindowCaptureTest class in the examples folder, when run it expects as first argument the PID
of the process to take the windows from (or -1 for all windows in the system), and saves a snapshot of
those windows into the Pictures folder. I think this example covers all functionalities currently supported
by this project.
