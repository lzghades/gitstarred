//
//  PreferenceWindowController.swift
//  GitStarred
//
//  Created by peter on 2018/1/17.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class PreferenceWindowController: NSWindowController, NSToolbarDelegate {
    
    var toolbar: NSToolbar!
    let toolbarItemIdentifiers = [NSToolbarItem.Identifier(rawValue: "ptbUserItem")]
    let toolbarItems = [
        "ptbUserItem": [
            "label": "账号设置",
            "paletteLabel": "账号设置"
        ]
    ]

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        toolbar = NSToolbar(identifier: NSToolbar.Identifier(rawValue: "preferenceToolbar"))
        toolbar.allowsUserCustomization = true
        toolbar.displayMode = .iconOnly
        toolbar.delegate = self
        toolbar.selectedItemIdentifier = toolbarItemIdentifiers[0]
        self.window?.toolbar = toolbar
    }
    
    func toolbarWillAddItem(_ notification: Notification) {}
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarItem: NSToolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        
        toolbarItem.label = toolbarItems[itemIdentifier.rawValue]!["label"]!
        toolbarItem.paletteLabel = toolbarItems[itemIdentifier.rawValue]!["paletteLabel"]!
        toolbarItem.image = NSImage(named: NSImage.Name.userAccounts)
        
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
}
