//
//  GSTextField.swift
//  GitStarred
//
//  Created by peter on 2018/1/19.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation
import Cocoa

class GSTextField: NSTextField {
    
    convenience init(placeholder: String, borderColor: NSColor = NSColor.clear, radius: CGFloat) {
        self.init()
        
        self.placeholderString = placeholder
        self.isBezeled = true
        self.bezelStyle = .roundedBezel
        self.focusRingType = .none

        self.wantsLayer = true
        self.layer?.cornerRadius = radius
        self.layer?.masksToBounds = false
        self.layer?.borderWidth = 1
        self.layer?.borderColor = borderColor.cgColor
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
