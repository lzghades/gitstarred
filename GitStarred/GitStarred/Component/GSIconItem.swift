//
//  GSIconItem.swift
//  GitStarred
//
//  Created by peter on 2018/1/25.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import SnapKit

class GSIconItem: NSView {
    
    var buttonIcon: NSImageView!
    var buttonLabel: GSLabel!
    var selected = false
    var delegate: IconItemDelegate?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    convenience init(icon: NSImage, label: String, selected: Bool) {
        self.init(frame: NSRect(x: 0, y: 0, width: 0, height: Common.iconItemHeight))
        self.wantsLayer = true
        self.selected = selected
        
        buttonIcon = NSImageView()
        buttonIcon.wantsLayer = true
        buttonIcon.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.96, alpha:1.00).cgColor
        buttonIcon.alignment = NSTextAlignment.center
        buttonIcon.layer?.masksToBounds = true
        buttonIcon.layer?.cornerRadius = 2
        
        icon.size = NSSize(width: 12, height: 12)
        buttonIcon.image = icon
        
        buttonLabel = GSLabel(color: .grayBright, fontSize: 14.0)
        buttonLabel.stringValue = label
        buttonLabel.sizeToFit()
        
        self.addSubview(buttonIcon)
        self.addSubview(buttonLabel)
        
        buttonIcon.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset((Common.iconItemHeight - Common.iconItemIconSize) / 2)
            make.left.equalTo(self).offset(8)
            make.width.equalTo(Common.iconItemIconSize)
            make.height.equalTo(Common.iconItemIconSize)
        }
        
        buttonLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset((CGFloat(Common.iconItemHeight) - buttonLabel.frame.size.height) / 2)
            make.left.equalTo(buttonIcon.snp.right).offset(6)
        }
        
        if (selected) {
            doSelected()
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        stateChange()
    }
    
    func stateChange() {
        if (selected) {
            unDoSelected()
        } else {
            doSelected()
        }
    }
    
    private func doSelected() {
        selected = true
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.19, alpha:1.00).cgColor
        
        delegate?.iconItemClick()
    }
    
    private func unDoSelected() {
        selected = false
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.00, alpha:0.00).cgColor
    }
}
