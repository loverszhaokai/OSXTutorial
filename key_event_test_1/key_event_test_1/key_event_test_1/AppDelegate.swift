//
//  AppDelegate.swift
//  key_event_test_1
//
//  Created by zhaokai on 5/19/16.
//  Copyright © 2016 zhaokai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    private var monitor : AnyObject?
    let popover = NSPopover()

    func eventCallBack(theEvent : NSEvent) {
        print("\t eventCallBack()")
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        print("\t >>applicationDidFinishLaunching()")
        
        /*
        monitor = NSEvent.addGlobalMonitorForEventsMatchingMask([.KeyDownMask]) { event in
            print("\t key event captured: keycode=\(event.description)")
        }
        
        monitor?.start()
        */
        
        // If you want to monitor KeyDown event, you must ' [System Preferences / Security & Privacy / Accessibility] to control your computer'
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask) {
            event in
            print("\t key down event")
        }
        
        print("\t <<applicationDidFinishLaunching()")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

