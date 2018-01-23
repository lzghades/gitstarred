//
//  LeftPanelViewController.swift
//  GitStarred
//
//  Created by peter on 2018/1/22.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import SnapKit

class Item: NSObject {
    var name = "t"
}

class LeftPanelViewController: NSViewController {
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        outlineView.backgroundColor = NSColor(hue:0.42, saturation:0.69, brightness:0.95, alpha:1.00)
    }
}

extension LeftPanelViewController: NSOutlineViewDataSource, NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return 2
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        let item = Item()
        return item
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var cell: NSTableCellView!
        
        cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GSOutlineCellView"), owner: self) as? GSOutlineCellView
//        cell.textField?.stringValue = (item as? Item)?.name ?? ""
//
        cell.textField?.stringValue = "fsdafs"
        cell.imageView?.image = NSImage(named: NSImage.Name.bonjour)
        
        return cell
    }
}
