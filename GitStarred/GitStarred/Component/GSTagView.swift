//
//  GSTagView.swift
//  GitStarred
//
//  Created by peter on 2018/3/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSTagView: NSView, TagDelegate {
    
    var userId: Int64 = 0
    var tagBadge: GSBadge!
    var tagBadges: [GSBadge] = []
    let padding = CGFloat(10)
    var tagList: [[GSBadge]] = [[GSBadge]]()
    var tagRow: [GSBadge] = [GSBadge]()
    var currentWidth = CGFloat(0)
    var lastWidth = CGFloat(0)
    var lastHeight = CGFloat(0)
    let badgeHeight = CGFloat(22)
    var tagColor: NSColor = NSColor(hue:0.00, saturation:0.00, brightness:0.96, alpha:1.00)
    var tagBg: NSColor = NSColor(hue:0.00, saturation:0.00, brightness:0.12, alpha:1.00)
    
    let tagService: TagService = TagService()
    
    override var isFlipped: Bool {
        get {
            return true
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    convenience init(userId: Int64, tagColor: NSColor?, tagBg: NSColor?) {
        self.init()
        
        if let tagColor = tagColor {
            self.tagColor = tagColor
        }
        
        if let tagBg = tagBg {
            self.tagBg = tagBg
        }
        
        self.userId = userId
        self.initTags(tags: tagService.getAll(userId: self.userId))
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    private func initTags(tags: [TagModel]) {
        self.tagBadges = []
        
        for tag in tags {
            tagBadge = GSBadge(color: self.tagColor, bgColor: self.tagBg)
            tagBadge.stringValue = "\(tag.name) [\(tag.repoCount)]"
            tagBadge.itemId = tag.id
            tagBadge.tagDelegate = self
            tagBadge.sizeToFit()
            self.tagBadges.append(tagBadge)
        }
    }
    
    func viewLayout(maxWidth: CGFloat) {
        tagList = []
        tagRow = []
        currentWidth = CGFloat(0)
        lastWidth = CGFloat(0)
        lastHeight = CGFloat(0)
        
        for tag in self.tagBadges {
            currentWidth += tag.frame.size.width + padding
            if (currentWidth > maxWidth) {
                currentWidth = CGFloat(0) + tag.frame.size.width + padding
                tagList.append(tagRow)
                tagRow = []
            }

            tagRow.append(tag)
        }
        tagList.append(tagRow)
        
        var itemFrameSize: CGSize = CGSize()
        for row in tagList {
            for item in row {
                item.removeFromSuperview()
                self.addSubview(item)
                lastWidth += padding
                
                itemFrameSize = item.frame.size
                item.snp.remakeConstraints({ (make) in
                    make.top.equalTo(self).offset(lastHeight)
                    make.left.equalTo(self).offset(lastWidth)
                    make.width.equalTo(itemFrameSize.width)
                    make.height.equalTo(itemFrameSize.height)
                })

                lastWidth += itemFrameSize.width
            }
            lastWidth = CGFloat(0)
            lastHeight += badgeHeight + padding
        }
        
        self.setFrameSize(NSSize(width: maxWidth, height: lastHeight))
    }
    
    func addRepoIntoTag(tagId: Int64, repoId: Int64) {
        tagService.addRepoIntoTag(tagId: tagId, repoId: repoId)
        self.initTags(tags: tagService.getAll(userId: self.userId))
        self.viewLayout(maxWidth: self.frame.size.width)
    }
}
