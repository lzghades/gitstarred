//
//  GSButton.swift
//  GitStarred
//
//  Created by peter on 2018/2/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    convenience init(title: String, textColor: NSColor, backgroundColor: NSColor, borderColor: NSColor, radius: CGFloat) {
        self.init()
        
        self.isBordered = false
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        self.attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: textColor, NSAttributedStringKey.font: NSFont.systemFont(ofSize: 11), NSAttributedStringKey.paragraphStyle: pstyle])
        self.alignment = .center
        self.bezelStyle = .regularSquare
        
        self.wantsLayer = true
        self.layer?.cornerRadius = radius
        self.layer?.masksToBounds = false
        self.layer?.borderWidth = 1.5
        self.layer?.borderColor = borderColor.cgColor
        self.layer?.backgroundColor = backgroundColor.cgColor
        self.layerContentsRedrawPolicy = .onSetNeedsDisplay
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var wantsUpdateLayer: Bool {
        return true
    }

    override func updateLayer() {
        super.updateLayer()
    }
}
