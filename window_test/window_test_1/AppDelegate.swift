//
//  AppDelegate.swift
//  window_test_1
//
//  Created by zhaokai on 5/10/16.
//  Copyright (c) 2016 zhaokai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let overlayWindow = NSWindow()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let screen = NSScreen.mainScreen()
        let rect: NSRect = screen!.frame
        let height = rect.size.height
        let width = rect.size.width
        var frame = screen!.frame
        frame.size = NSMakeSize(width, height)
        
        overlayWindow.setFrame(frame, display: true)
        overlayWindow.titlebarAppearsTransparent = true
        overlayWindow.titleVisibility = NSWindowTitleVisibility.Hidden
        overlayWindow.styleMask |= NSFullSizeContentViewWindowMask
        overlayWindow.styleMask |= NSBorderlessWindowMask
        overlayWindow.level = 10000000
        overlayWindow.setIsVisible(true)
        overlayWindow.backgroundColor = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
        overlayWindow.movable = false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
