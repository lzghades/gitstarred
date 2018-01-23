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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarIcon"))
            button.action = #selector(activeWindow)
        }
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "激活GitStarred", action: #selector(activeWindow), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "我的GitHub", action: #selector(gotoGitHub), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "退出", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        
        statusItem.menu = menu
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
}

