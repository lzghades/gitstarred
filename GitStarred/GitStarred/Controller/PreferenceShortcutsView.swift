//
//  PreferenceShortCutsView.swift
//  GitStarred
//
//  Created by peter on 2018/2/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class PreferenceShortcutsView: NSView {
    
    var contentView: NSView!
    var nameLabel: GSLabel!
    var valueLabel: GSLabel!
    var shortcuts: [[String: String]] = [
        [
            "name": "Sync All",
            "value": "⌘ + R"
        ]
    ]
    var lineHeight = 0

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    convenience init(toolbarHeight: CGFloat) {
        self.init()
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00).cgColor
        
        contentView = NSView()
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(toolbarHeight + 20)
            make.right.equalTo(self).offset(-80)
            make.bottom.equalTo(self).offset(-20)
            make.left.equalTo(self).offset(80)
        }
        
        for shortcut in shortcuts {
            nameLabel = GSLabel(color: .gray, fontSize: 14.0)
            nameLabel.stringValue = shortcut["name"]!
            nameLabel.sizeToFit()
            contentView.addSubview(nameLabel)
            nameLabel.snp.makeConstraints({ (make) in
                make.top.left.equalTo(contentView).offset(0)
            })
            
            valueLabel = GSLabel(color: .gray, fontSize: 14.0)
            valueLabel.stringValue = shortcut["value"]!
            valueLabel.sizeToFit()
            contentView.addSubview(valueLabel)
            valueLabel.snp.makeConstraints({ (make) in
                make.top.right.equalTo(contentView).offset(0)
            })
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
