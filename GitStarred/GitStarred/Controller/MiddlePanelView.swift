//
//  MiddlePanelView.swift
//  GitStarred
//
//  Created by peter on 2018/1/24.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import SnapKit

class MiddlePanelView: NSView, NSTableViewDataSource, NSTableViewDelegate {
    
    let gitHubService: GitHubService = GitHubService()
    var tableView: NSTableView!
    var scrollView: NSScrollView!
    var listData: [StarredModel] = []
    var cellHeights: [[String: CGFloat]] = []

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.13, saturation:0.02, brightness:0.98, alpha:1.00).cgColor
        
        scrollView = NSScrollView()
        scrollView.borderType = .noBorder
        scrollView.backgroundColor = .clear
        scrollView.drawsBackground = false
        scrollView.scrollerStyle = .overlay
        scrollView.hasVerticalScroller = true
        scrollView.scrollerKnobStyle = .dark
        scrollView.verticalScrollElasticity = .automatic
        scrollView.autohidesScrollers = true
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
        }
        
        tableView = NSTableView(frame: .zero)
        tableView.rowSizeStyle = .custom
        tableView.backgroundColor = .clear
        tableView.allowsEmptySelection = true
        tableView.allowsMultipleSelection = false
        tableView.allowsColumnSelection = false
        tableView.intercellSpacing = NSSize(width: 0, height: 0)
        tableView.selectionHighlightStyle = .none

        tableView.headerView = nil
        tableView.addTableColumn(NSTableColumn(identifier: .init("GSColumn")))
        tableView.delegate = self
        tableView.dataSource = self

        scrollView.documentView = tableView
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func refresh(finished: @escaping () -> Void) {
        gitHubService.getStarreds { (resp) in
            self.listData = resp
            
            let animation = NSTableView.AnimationOptions.effectFade.rawValue | NSTableView.AnimationOptions.slideDown.rawValue | NSTableView.AnimationOptions.slideUp.rawValue
            
            for i in 0..<self.listData.count {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: IndexSet.init(integer: i), withAnimation: NSTableView.AnimationOptions(rawValue: animation))
                self.tableView.endUpdates()
            }
            
            finished()
        }
    }
    
    func tableViewColumnDidResize(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let rowData = self.listData[row]
        
        let cell = GSCellView(repoName: rowData.name, repoDescription: rowData.description)
        let height = cell.getHeight(width: self.tableView.frame.size.width - CGFloat(Common.cellViewPadding * 2))

        cellHeights.append(height)
        return height["totalHeight"]!
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell = tableView.makeView(withIdentifier: .init(Common.cellViewIdentifier), owner: self) as? GSCellView
  
        if (cell == nil) {
            cell = GSCellView()
        }
        
        let rowData = self.listData[row]

        cell?.repoName.stringValue = rowData.name
        cell?.repoDescription.stringValue = rowData.description
        cell?.makeLayout()
        
        cell?.repoDescription.snp.updateConstraints({ (make) in
            make.top.equalTo(cell!).offset(CGFloat(cellHeights[row]["nameHeight"]!) + CGFloat(Common.cellViewPadding) + 2)
        })
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let lastRowIndex = tableView.selectedRow
        let currentRow = tableView.rowView(atRow: row, makeIfNecessary: false)
        
        if (lastRowIndex >= 0 ) {
            tableView.rowView(atRow: lastRowIndex, makeIfNecessary: false)?.backgroundColor = .clear
            
        }
        
        currentRow?.backgroundColor = NSColor(hue:0.12, saturation:0.03, brightness:0.94, alpha:1.00)
        
        return true
    }
}
