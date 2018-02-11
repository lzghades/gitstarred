//
//  GSCellView.swift
//  GitStarred
//
//  Created by peter on 2018/1/30.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSCellView: NSTableCellView {

    var repoName: GSLabel!
    var repoDescription: GSLabel!

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
        self.addSubview(repoName)
        self.addSubview(repoDescription)
        
        repoName.snp.remakeConstraints { (make) in
            make.top.equalTo(self).offset(Common.cellViewPadding)
            make.left.equalTo(self).offset(Common.cellViewPadding)
            make.right.equalTo(self).offset(-Common.cellViewPadding)
        }
        
        repoDescription.snp.remakeConstraints { (make) in
            make.top.equalTo(self).offset(Common.cellViewPadding)
            make.left.equalTo(self).offset(Common.cellViewPadding)
            make.right.equalTo(self).offset(-Common.cellViewPadding)
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
                "totalHeight": nameHeight + descriptionHeight + CGFloat(Common.cellViewPadding * 2),
                "nameHeight": nameHeight,
                "descriptionHeight": descriptionHeight
            ]
        } else {
            return [
                "totalHeight": CGFloat(17 + 14 + Common.cellViewPadding * 2),
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
        self.repoName = GSLabel(color: .grayDark, fontSize: 13.0, isBold: true)
        self.repoDescription = GSLabel(color: .grayDark, fontSize: 11.0)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
