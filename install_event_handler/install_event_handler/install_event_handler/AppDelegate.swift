//
//  AppDelegate.swift
//  install_event_handler
//
//  Created by zhaokai on 5/20/16.
//  Copyright © 2016 zhaokai. All rights reserved.
//

import Cocoa
import Carbon

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        
        HotKey.register(6, modifiers: UInt32(cmdKey)) { () -> () in
            print("got Hotkey here")
        }
        
        //testInstallEventHandler()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func testInstallEventHandler() {
        NSLog(">> testInstallEventHandler()")
        
        var hotKey: EventHotKeyRef = nil
        var eventHandler: EventHandlerRef = nil
        let hotKeyID = EventHotKeyID(signature: 1, id: 1)
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        
        var eventTargetRef = GetApplicationEventTarget()

        InstallEventHandler(eventTargetRef,
            {(nextHandler : EventHandlerCallRef, theEvent : EventRef, userdata) -> OSStatus in
                NSLog("\t find event: kEventHotKeyPressed")
                return noErr
            },
            1, &eventType, nil, &eventHandler)
        
        NSLog("<< testInstallEventHandler()")
    }

}

class HotKey {
    private let hotKey: EventHotKeyRef
    private let eventHandler: EventHandlerRef
    private var registered = true
    
    private init(hotKey: EventHotKeyRef, eventHandler: EventHandlerRef) {
        self.hotKey = hotKey
        self.eventHandler = eventHandler
    }
    
    static func register(keyCode: UInt32, modifiers: UInt32, block: () -> ()) -> HotKey? {
        var hotKey: EventHotKeyRef = nil
        var eventHandler: EventHandlerRef = nil
        let hotKeyID = EventHotKeyID(signature: 1, id: 1)
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))
        
        let ptr = UnsafeMutablePointer<() -> ()>.alloc(1)
        ptr.initialize(block)
        
        guard InstallEventHandler(GetApplicationEventTarget(), {(_: EventHandlerCallRef, _: EventRef, ptr: UnsafeMutablePointer<Void>) -> OSStatus in
            UnsafeMutablePointer<() -> ()>(ptr).memory()
            return noErr
            }, 1, &eventType, ptr, &eventHandler) == noErr &&
            RegisterEventHotKey(keyCode, modifiers, hotKeyID, GetApplicationEventTarget(), OptionBits(0), &hotKey) == noErr else {return nil}
        return HotKey(hotKey: hotKey, eventHandler: eventHandler)
    }
    
    func unregister() {
        guard registered else {return}
        UnregisterEventHotKey(hotKey)
        RemoveEventHandler(eventHandler)
        registered = false
    }
}


