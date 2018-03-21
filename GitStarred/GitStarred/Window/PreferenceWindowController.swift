//
//  PreferenceWindowController.swift
//  GitStarred
//
//  Created by peter on 2018/1/17.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

struct ItemIdentifiers {
    static let userItem = "ptbUserItem"
    static let shortcutsItem = "ptbShortcutsItem"
}

struct Size {
    static let width = 480
    static let height = 300
}

class PreferenceWindowController: NSWindowController, NSToolbarDelegate {
    
    var toolbar: NSToolbar!
    let toolbarItemIdentifiers = [
        NSToolbarItem.Identifier(rawValue: ItemIdentifiers.userItem),
        NSToolbarItem.Identifier(rawValue: ItemIdentifiers.shortcutsItem)
    ]
    let toolbarItems = [
        ItemIdentifiers.userItem: [
            "label": "Account",
            "paletteLabel": "Account"
        ],
        ItemIdentifiers.shortcutsItem: [
            "label": "Shortcuts",
            "paletteLabel": "Shortcuts"
        ]
    ]
    
    var preferenceUserView: PreferenceUserView!
    var preferenceShortcutsView: PreferenceShortcutsView!
    var toolbarHeight: CGFloat!

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        if let screenSize = NSScreen.main?.frame.size {
            self.window?.setFrame(NSRect(x: (Int(screenSize.width) - Size.width) / 2, y: (Int(screenSize.height) - Size.height - 60), width: Size.width, height: Size.height), display: true)
        }
        
        toolbar = NSToolbar(identifier: NSToolbar.Identifier(rawValue: "preferenceToolbar"))
        toolbar.sizeMode = .small
        toolbar.allowsUserCustomization = true
        toolbar.displayMode = .iconAndLabel
        toolbar.delegate = self
        toolbar.selectedItemIdentifier = toolbarItemIdentifiers[0]
        self.window?.toolbar = toolbar
        
        toolbarHeight = CGFloat(Size.height) - (window?.contentLayoutRect.height)!
        
        preferenceUserView = PreferenceUserView(toolbarHeight: toolbarHeight)
        preferenceShortcutsView = PreferenceShortcutsView(toolbarHeight: toolbarHeight)
        
        self.window?.contentView = preferenceUserView
    }
    
    func toolbarWillAddItem(_ notification: Notification) {}
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarItem: NSToolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        
        toolbarItem.label = toolbarItems[itemIdentifier.rawValue]!["label"]!
        toolbarItem.paletteLabel = toolbarItems[itemIdentifier.rawValue]!["paletteLabel"]!
        toolbarItem.image = NSImage(named: NSImage.Name("\(toolbarItems[itemIdentifier.rawValue]!["label"]!)Item"))
        toolbarItem.target = self
        toolbarItem.action = #selector(toolbarItemChange(sender:))
        
        return toolbarItem
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    @objc func toolbarItemChange(sender: Any) {
        let item = sender as! NSToolbarItem
        
        if (item.itemIdentifier.rawValue == ItemIdentifiers.userItem) {
            self.window?.contentView = preferenceUserView
        } else if (item.itemIdentifier.rawValue == ItemIdentifiers.shortcutsItem) {
            self.window?.contentView = preferenceShortcutsView
        }
    }
}
