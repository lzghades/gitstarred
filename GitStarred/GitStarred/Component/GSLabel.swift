//
//  GSLabel.swift
//  GitStarred
//
//  Created by peter on 2018/1/18.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation
import Cocoa

class GSLabel: NSTextField {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.isEditable = false
        self.isSelectable = false
        self.drawsBackground = false
        self.isBezeled = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
