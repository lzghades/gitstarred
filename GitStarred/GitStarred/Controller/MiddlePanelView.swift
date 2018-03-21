//
//  MiddlePanelView.swift
//  GitStarred
//
//  Created by peter on 2018/1/24.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class MiddlePanelView: NSView {
    
    var gsSearchBarView: GSSearchBar!
    var tableView: GSTableView!
    var scrollView: GSScrollView!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.13, saturation:0.02, brightness:0.98, alpha:1.00).cgColor
        
        gsSearchBarView = GSSearchBar()
        self.addSubview(gsSearchBarView)
        gsSearchBarView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(self).offset(0)
            make.height.equalTo(42)
        }
        
        scrollView = GSScrollView()
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.right.bottom.left.equalTo(self).offset(0)
        }
        
        tableView = GSTableView(frame: .zero)
        scrollView.documentView = tableView
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func refresh(repos: [RepoModel]) {
        self.tableView.listData = []
        self.tableView.reloadData()
        
        self.tableView.listData = repos
        
        let animation = NSTableView.AnimationOptions.effectFade.rawValue | NSTableView.AnimationOptions.slideDown.rawValue | NSTableView.AnimationOptions.slideUp.rawValue
        
        for i in 0..<repos.count {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: IndexSet.init(integer: i), withAnimation: NSTableView.AnimationOptions(rawValue: animation))
            self.tableView.endUpdates()
        }
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    @objc func repoAddTag() {        
        self.tableView.selectRowIndexes(IndexSet(integer: self.tableView.clickedRow), byExtendingSelection: false)
    }
}
