//
//  GSMenuItem.swift
//  GitStarred
//
//  Created by peter on 2018/3/14.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSMenuItem: NSMenuItem {
    
    var itemId: Int64!
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override init(title string: String, action selector: Selector?, keyEquivalent charCode: String) {
        super.init(title: string, action: selector, keyEquivalent: charCode)
    }
    
    convenience init(title: String, action: Selector, itemId: Int64) {
        self.init(title: title, action: action, keyEquivalent: "")
        
        self.itemId = itemId
    }
}
