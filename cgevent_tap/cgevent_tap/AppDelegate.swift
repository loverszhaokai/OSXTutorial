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
        NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    }

}

