//
//  GSScrollView.swift
//  GitStarred
//
//  Created by peter on 2018/3/9.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSScrollView: NSScrollView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.borderType = .noBorder
        self.backgroundColor = .clear
        self.drawsBackground = false
        self.scrollerStyle = .overlay
        self.hasVerticalScroller = true
        self.scrollerKnobStyle = .dark
        self.verticalScrollElasticity = .automatic
        self.autohidesScrollers = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
