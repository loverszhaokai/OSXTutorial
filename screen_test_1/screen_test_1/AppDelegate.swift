//
//  AppDelegate.swift
//  screen_test_1
//
//  Created by zhaokai on 5/16/16.
//  Copyright © 2016 zhaokai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var all_windows: [NSWindow] = [NSWindow]()
    
    var win_1 = NSWindow()
    var win_2 = NSWindow()
    var win_3 = NSWindow()

    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        initAllWindows()
        print("initAllWindows() finished")
        func keyDown(theEvent: NSEvent) {
            print("press key:\(theEvent.keyCode.description)")
            if (theEvent.keyCode == 1) {
                print("test!!")
            }
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func initAllWindows() {
        for screen in NSScreen.screens()! {
            let win = NSWindow()
            win.level = Int(CGWindowLevelForKey(.StatusWindowLevelKey))
            win.titlebarAppearsTransparent  =   true
            win.titleVisibility             =   .Hidden
            win.styleMask = NSBorderlessWindowMask
            
            var frame = screen.frame
            frame.size = CGSize(width: 400, height: 400)
            win.setFrame(frame, display: true)
            
            win.makeKeyAndOrderFront(win)
            all_windows.append(win)
        }
    }

}

