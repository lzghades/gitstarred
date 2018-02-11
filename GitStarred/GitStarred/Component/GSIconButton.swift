//
//  GSButton.swift
//  GitStarred
//
//  Created by peter on 2018/1/19.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation
import Cocoa

class GSIconButton: NSButton {
    convenience init(icon: NSImage) {
        self.init()
        
        icon.size = NSSize(width: 16, height: 16)
        self.image = icon
        self.isBordered = false
        self.bezelStyle = .texturedSquare
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

