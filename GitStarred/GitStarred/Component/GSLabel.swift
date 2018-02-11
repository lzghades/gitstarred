//
//  GSLabel.swift
//  GitStarred
//
//  Created by peter on 2018/1/18.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation
import Cocoa

enum FontColor {
    case grayBright
    case grayDark
    case gray1
}

class GSLabel: NSTextField {
    
    convenience init(color: FontColor, fontSize: CGFloat, isBold: Bool = false) {
         self.init()
        
        self.isEditable = false
        self.isSelectable = false
        self.drawsBackground = false
        self.isBezeled = false
        self.isBordered = false
        self.textColor = getColor(color: color)
        self.lineBreakMode = .byWordWrapping
        self.alignment = .left
        
        if (isBold) {
            self.font = NSFont.boldSystemFont(ofSize: fontSize)
        } else {
            self.font = NSFont.systemFont(ofSize: fontSize)
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func getColor(color: FontColor) -> NSColor {
        switch (color) {
        case .grayDark:
            return NSColor(hue:0.83, saturation:0.01, brightness:0.57, alpha:1.00)
        case .grayBright:
            return NSColor(hue:0.00, saturation:0.00, brightness:0.87, alpha:1.00)
        case .gray1:
            return NSColor(hue:0.60, saturation:0.03, brightness:0.70, alpha:1.00)
        }
    }
}
