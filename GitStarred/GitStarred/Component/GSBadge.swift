//
//  GSBadge.swift
//  GitStarred
//
//  Created by peter on 2018/3/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

private var GSBADGE_ITEMID_PROPERTY = 0

extension NSTextField {
    var itemId: Int64 {
        get {
            return objc_getAssociatedObject(self, &GSBADGE_ITEMID_PROPERTY) as! Int64
        }
        set {
            objc_setAssociatedObject(self, &GSBADGE_ITEMID_PROPERTY, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

class GSBadge: NSTextField {
    
    var tagDelegate: TagDelegate?
    
    convenience init(color: NSColor, bgColor: NSColor) {
        self.init()
        
        self.isEditable = false
        self.isSelectable = false
        self.drawsBackground = true
        self.isBezeled = false
        self.isBordered = true
        self.textColor = color
        self.lineBreakMode = .byClipping
        self.alignment = .center
        self.backgroundColor = bgColor
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 3.0
        self.layer?.masksToBounds = false
        self.layer?.borderWidth = 1
        self.layer?.borderColor = bgColor.cgColor
        
        self.font = NSFont.systemFont(ofSize: 13.0)
        
        self.registerForDraggedTypes([.string])
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseDown(with event: NSEvent) {
        print(self.itemId)
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {        
        let pasteBoard = sender.draggingPasteboard()
        if let item = pasteBoard.pasteboardItems?.first {
            self.tagDelegate?.addRepoIntoTag(tagId: self.itemId, repoId: Int64(item.string(forType: .string)!)!)
        }
        
        return true
    }
}
