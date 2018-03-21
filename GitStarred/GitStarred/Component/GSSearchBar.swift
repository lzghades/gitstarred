//
//  GSSearchBar.swift
//  GitStarred
//
//  Created by peter on 2018/3/16.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSSearchBar: NSView, NSTextFieldDelegate {
    
    var searchbar: GSTextField!
    
    let repoService: RepoService = RepoService()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        searchbar = GSTextField(placeholder: "Search", borderColor: NSColor(hue:0.00, saturation:0.00, brightness:0.87, alpha:1.00), radius: 14.0)
        searchbar.backgroundColor = NSColor.clear
        searchbar.delegate = self
        searchbar.identifier = NSUserInterfaceItemIdentifier(rawValue: Common.searchbarIdentifier)
        self.addSubview(searchbar)
        searchbar.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-8)
            make.left.equalTo(self).offset(5)
        }
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? GSTextField, searchbar.identifier == textField.identifier {
            let text = textField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if (text.count > 0) {
                print(repoService.search(text: text))
            }
        }
    }
}
