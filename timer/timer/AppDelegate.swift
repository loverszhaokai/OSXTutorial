//
//  AppDelegate.swift
//  timer
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
        
        testTimer()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func update() {
        NSLog(">> \tupdate()")
        NSLog("<< \tupdate()")
    }
    
    func testTimer() {
        NSLog(">> testTimer()")
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "update", userInfo: nil, repeats: true)
        
        NSLog("<< testTimer()")
    }
}

