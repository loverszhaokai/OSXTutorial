//
//  main.m
//  cgevent_tap_objc
//
//  Created by zhaokai on 5/20/16.
//  Copyright © 2016 zhaokai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Cocoa/Cocoa.h>

CGEventRef myCGEventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    //0x0b is the virtual keycode for "b"
    //0x09 is the virtual keycode for "v"
    if (CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode) == 0x0B) {
        CGEventSetIntegerValueField(event, kCGKeyboardEventKeycode, 0x09);
        return Nil;
    }
    
    return event;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    
    CFRunLoopSourceRef runLoopSource;
    
    CFMachPortRef eventTap = CGEventTapCreate(kCGHIDEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault, kCGEventMaskForAllEvents, myCGEventCallback, NULL);
    
    if (!eventTap) {
        NSLog(@"Couldn't create event tap!");
        exit(1);
    }
    
    runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
    
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
    
    CGEventTapEnable(eventTap, true);
    
    CFRunLoopRun();
    
    CFRelease(eventTap);
    CFRelease(runLoopSource);
    
    exit(0);
    
    
    return 0;
}
