//
//  AppDelegate.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    var mainWindow: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarIcon"))
            button.action = #selector(activeWindow)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Toggle GitStarred", action: #selector(activeWindow), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "My GitHub", action: #selector(gotoGitHub), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        
        statusItem.menu = menu
        
        guard let screenSize = NSScreen.main?.frame.size else {
            return
        }
        
        let w = screenSize.width * 0.8
        let h = screenSize.height * 0.8
        let x = (screenSize.width - w) / 2
        let y = (screenSize.height - h) / 2
        let frame = NSRect(x: x, y: y, width: w, height: h)

        mainWindow.setFrame(frame, display: true)
        mainWindow.showsToolbarButton = true
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.titleVisibility = .hidden
        mainWindow.styleMask = NSWindow.StyleMask(rawValue:  mainWindow.styleMask.rawValue | NSWindow.StyleMask.fullSizeContentView.rawValue)
        mainWindow.title = ""
        mainWindow.isReleasedWhenClosed = false
    }
    
    @objc func activeWindow() {
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func gotoGitHub() {
        NSWorkspace.shared.open(URL(string: GitHubUrls.setting)!)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        mainWindow.makeKeyAndOrderFront(self)
        return true
    }
}

