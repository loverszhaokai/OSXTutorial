//
//  AppDelegate.swift
//  cgevent_tap
//
//  Created by zhaokai on 5/20/16.
//  Copyright © 2016 zhaokai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        testCGEventTap()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func testCGEventTap() {
        let eventMask = (1 << CGEventType.KeyDown.rawValue) | (1 << CGEventType.KeyUp.rawValue)
        guard let eventTap = CGEventTapCreate(.CGSessionEventTap,
            .HeadInsertEventTap,
            .Default,
            CGEventMask(eventMask),
            myCGEventCallback,
            nil) else {
                print("failed to create event tap")
                exit(1)
        }
        
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes)
        CGEventTapEnable(eventTap, true)
        CFRunLoopRun()
    }

}

func myCGEventCallback(proxy : CGEventTapProxy, type : CGEventType, event : CGEvent, refcon : UnsafeMutablePointer<Void>) -> Unmanaged<CGEvent>? {
    
    if [.KeyDown , .KeyUp].contains(type) {
        var keyCode = CGEventGetIntegerValueField(event, .KeyboardEventKeycode)
        NSLog("keyCode=\(keyCode)")
        if keyCode == 0 {
            keyCode = 6
        } else if keyCode == 6 {
            keyCode = 0
        }
        CGEventSetIntegerValueField(event, .KeyboardEventKeycode, keyCode)
        return nil
    }
    return Unmanaged.passRetained(event)
}

