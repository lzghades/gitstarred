//
//  GSOutlineCellView.swift
//  GitStarred
//
//  Created by peter on 2018/1/22.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSOutlineCellView: NSTableCellView {
    
    var v: NSView!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        v = NSView(frame: NSRect(x: 0, y: 0, width: 10, height: 10))
        v.wantsLayer = true
        v.layer?.backgroundColor = NSColor(hue:0.70, saturation:0.43, brightness:0.34, alpha:1.00).cgColor
        self.addSubview(v)
    }
}
