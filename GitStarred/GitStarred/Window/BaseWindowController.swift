//
//  BaseWindowController.swift
//  GitStarred
//
//  Created by peter on 2018/1/16.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class BaseWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.mainWindow = self.window
    }
}
