//
//  PreferenceShortCutsView.swift
//  GitStarred
//
//  Created by peter on 2018/2/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class PreferenceShortcutsView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00).cgColor
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
