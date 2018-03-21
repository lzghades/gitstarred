//
//  GSTableView.swift
//  GitStarred
//
//  Created by peter on 2018/3/8.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class GSTableView: NSTableView, NSMenuDelegate, NSTableViewDelegate, NSTableViewDataSource {
    
    let mainMenu: NSMenu = NSMenu()
    let subMenu: NSMenu = NSMenu()
    let addTagMenuItem: NSMenuItem = NSMenuItem()
    
    var listData: [RepoModel] = []
    var cellHeights: [[String: CGFloat]] = []
    var lastSelected = 0
    var currentSelected = 0
    
    var listDelegate: ListDelegate?
    let tagService: TagService = TagService()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.rowSizeStyle = .custom
        self.backgroundColor = .clear
        self.allowsEmptySelection = true
        self.allowsMultipleSelection = false
        self.allowsColumnSelection = false
        self.intercellSpacing = NSSize(width: 0, height: 0)
        self.selectionHighlightStyle = .none
        self.headerView = nil
        self.addTableColumn(NSTableColumn(identifier: .init("GSColumn")))
        
        self.delegate = self
        self.dataSource = self
        
        self.registerForDraggedTypes([.string])
        self.setDraggingSourceOperationMask(.copy, forLocal: true)
        
        addTagMenuItem.title = "Add Tag"
        addTagMenuItem.image = NSImage(named: NSImage.Name("Tag"))
        addTagMenuItem.image?.size = NSSize(width: 16, height: 16)
        addTagMenuItem.submenu = subMenu
        
        mainMenu.addItem(addTagMenuItem)
        mainMenu.delegate = self
        self.menu = mainMenu
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let rowData = self.listData[row]
        
        let cell = GSCellView(repoName: rowData.name, repoDescription: rowData.description)
        let height = cell.getHeight(width: self.frame.size.width - CGFloat(Common.cellViewPadding * 2) - 38)
        
        cellHeights.append(height)
        return height["totalHeight"]!
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cell = tableView.makeView(withIdentifier: .init(Common.cellViewIdentifier), owner: self) as? GSCellView
        
        if (cell == nil) {
            cell = GSCellView()
        }
        
        let rowData = self.listData[row]
        
        cell?.ownerName.stringValue = rowData.ownerName
        cell?.updateDate.stringValue = self.dateParse(updateDate: rowData.updateDate)
        cell?.repoName.stringValue = rowData.name
        cell?.repoDescription.stringValue = rowData.description
        cell?.ownerAvatar.kf.setImage(with: URL(string: rowData.ownerAvatar))
        
        cell?.makeLayout()
        
        let rightBottomViewHeight = CGFloat(cellHeights[row]["nameHeight"]!) + CGFloat(cellHeights[row]["descriptionHeight"]!) + 2
        
        cell?.rightView.snp.updateConstraints({ (make) in
            make.height.equalTo(rightBottomViewHeight + 2 + 18)
        })
        
        cell?.rightBottomView.snp.updateConstraints({ (make) in
            make.height.equalTo(rightBottomViewHeight)
        })
        
        cell?.repoDescription.snp.updateConstraints({ (make) in
            make.top.equalTo((cell?.rightBottomView)!).offset(CGFloat(cellHeights[row]["nameHeight"]!) + 2)
        })
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let lastRowIndex = tableView.selectedRow
        let currentRow = tableView.rowView(atRow: row, makeIfNecessary: false)
        
        if (lastRowIndex >= 0 ) {
            tableView.rowView(atRow: lastRowIndex, makeIfNecessary: false)?.backgroundColor = .clear
            lastSelected = lastRowIndex
        }
        
        currentRow?.backgroundColor = NSColor(hue:0.12, saturation:0.03, brightness:0.94, alpha:1.00)
        
        currentSelected = row
        return true
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if (lastSelected >= 0 ) {
            self.rowView(atRow: lastSelected, makeIfNecessary: false)?.backgroundColor = .clear
        }
        
        let currentRow = self.rowView(atRow: currentSelected, makeIfNecessary: false)
        currentRow?.backgroundColor = NSColor(hue:0.12, saturation:0.03, brightness:0.94, alpha:1.00)
        
        listDelegate?.selectRepo(repo: self.listData[currentSelected])
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        let rowData = self.listData[rowIndexes.first!]
        let item = NSPasteboardItem()
        item.setString(String(rowData.id), forType: .string)
        pboard.writeObjects([item])
        return true
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        if (self.selectedRow >= 0) {
            lastSelected = self.selectedRow
        }
        
        currentSelected = self.clickedRow
        let rowData = self.listData[currentSelected]
        self.subMenu.removeAllItems()
        for tag in tagService.excludTags(repoId: rowData.id) {
            let item = GSMenuItem(title: tag.name, action: #selector(addRepoIntoTag), itemId: tag.id)
            self.subMenu.addItem(item)
        }
        
        self.selectRowIndexes(IndexSet(integer: self.clickedRow), byExtendingSelection: false)
    }
    
    private func dateParse(updateDate: String) -> String {
        let githubFormatter = "yyyy-MM-dd'T'HH:mm:ssZ"
        let localFormatter = "yyyy/MM/dd"
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = githubFormatter
        let date = dateformatter.date(from: updateDate)
        
        dateformatter.dateFormat = localFormatter
        
        return dateformatter.string(from: date!)
    }
    
    @objc func addRepoIntoTag(sender: GSMenuItem) {
        let rowData = self.listData[currentSelected]
        
        tagService.addRepoIntoTag(tagId: sender.itemId, repoId: rowData.id)
    }
}
