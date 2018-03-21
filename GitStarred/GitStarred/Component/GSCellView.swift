//
//  GSCellView.swift
//  GitStarred
//
//  Created by peter on 2018/1/30.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import Kingfisher

class GSCellView: NSTableCellView {
    
    var ownerAvatar: NSImageView!
    var ownerName: GSLabel!
    var updateDate: GSLabel!
    var repoName: GSLabel!
    var repoDescription: GSLabel!
    var leftView: NSView!
    var rightView: NSView!
    var rightTopView: NSView!
    var rightBottomView: NSView!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    convenience init(repoName: String, repoDescription: String) {
        self.init()
        
        setProperty(repoName: repoName, repoDescription: repoDescription)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.identifier = .init(Common.cellViewIdentifier)
        initProperty()
    }
    
    func makeLayout() {
        self.addSubview(self.leftView)
        self.addSubview(self.rightView)
        
        self.leftView.addSubview(self.ownerAvatar)
        
        self.rightView.addSubview(self.rightTopView)
        self.rightView.addSubview(self.rightBottomView)
        
        self.rightTopView.addSubview(self.ownerName)
        self.rightTopView.addSubview(self.updateDate)
        
        self.rightBottomView.addSubview(self.repoName)
        self.rightBottomView.addSubview(self.repoDescription)
        
        self.leftView.snp.remakeConstraints { (make) in
            make.top.left.equalTo(self).offset(Common.cellViewPadding)
            make.width.equalTo(24)
            make.height.equalTo(42)
        }
        
        self.rightView.snp.remakeConstraints { (make) in
            make.top.equalTo(self).offset(Common.cellViewPadding)
            make.left.equalTo(self).offset(38)
            make.right.equalTo(self).offset(-Common.cellViewPadding)
            make.height.equalTo(0)
        }
        
        self.rightTopView.snp.remakeConstraints { (make) in
            make.top.right.left.equalTo(self.rightView).offset(0)
            make.height.equalTo(18)
        }
        
        self.rightBottomView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.rightTopView.snp.bottom).offset(2)
            make.right.left.equalTo(self.rightView).offset(0)
            make.height.equalTo(0)
        }
        
        self.ownerAvatar.snp.remakeConstraints { (make) in
            make.top.equalTo(self.leftView).offset(10)
            make.left.equalTo(self.leftView).offset(0)
            make.width.height.equalTo(24)
        }
        
        self.ownerName.snp.remakeConstraints { (make) in
            make.top.left.equalTo(self.rightTopView).offset(0)
        }
        
        self.updateDate.snp.remakeConstraints { (make) in
            make.top.right.equalTo(self.rightTopView).offset(0)
        }
        
        self.repoName.snp.remakeConstraints { (make) in
            make.top.right.left.equalTo(self.rightBottomView).offset(0)
        }
        
        self.repoDescription.snp.remakeConstraints { (make) in
            make.top.right.left.equalTo(self.rightBottomView).offset(0)
        }
    }
    
    func getHeight(width: CGFloat) -> [String: CGFloat] {
        repoName.preferredMaxLayoutWidth = width
        repoDescription.preferredMaxLayoutWidth = width
        repoName.sizeToFit()
        repoDescription.sizeToFit()
        
        let repoNameHeight = repoName.cell?.cellSize(forBounds: NSRect(x: CGFloat(0.0), y: CGFloat(0.0), width: width, height: CGFloat(Float.greatestFiniteMagnitude))).height
        let repoDescriptionHeight = repoDescription.cell?.cellSize(forBounds: NSRect(x: CGFloat(0.0), y: CGFloat(0.0), width: width, height: CGFloat(Float.greatestFiniteMagnitude))).height
        
        if let nameHeight = repoNameHeight, let descriptionHeight = repoDescriptionHeight {
            return [
                "totalHeight": nameHeight + descriptionHeight + 2 + CGFloat(Common.cellViewPadding * 2) + 2 + 18,
                "nameHeight": nameHeight,
                "descriptionHeight": descriptionHeight
            ]
        } else {
            return [
                "totalHeight": CGFloat(17 + 14 + 2 + Common.cellViewPadding * 2) + 2 + 18,
                "nameHeight": CGFloat(17),
                "descriptionHeight": CGFloat(14)
            ]
        }
    }
    
    fileprivate func setProperty(repoName: String, repoDescription: String) {
        self.initProperty()
        
        self.repoName.stringValue = repoName
        self.repoDescription.stringValue = repoDescription
    }
    
    fileprivate func initProperty() {
        self.leftView = NSView()
        self.rightView = NSView()
        self.rightTopView = NSView()
        self.rightBottomView = NSView()
        
        self.ownerName = GSLabel(color: .grayDark, fontSize: 12.0)
        self.updateDate = GSLabel(color: .grayDark, fontSize: 11.0)
        self.repoName = GSLabel(color: .grayDark, fontSize: 13.0, isBold: true)
        self.repoDescription = GSLabel(color: .grayDark, fontSize: 11.0)
        
        self.ownerAvatar = NSImageView()
        self.ownerAvatar.wantsLayer = true
        self.ownerAvatar.layer?.cornerRadius = 12
        self.ownerAvatar.layer?.masksToBounds = false
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
