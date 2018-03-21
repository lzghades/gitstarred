//
//  AddTagViewController.swift
//  GitStarred
//
//  Created by peter on 2018/3/6.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class AddTagViewController: NSViewController {
    
    var titleLabel: GSLabel!
    var tagTextField: GSTextField!
    var addButton: GSButton!
    let bgColor: NSColor = NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00)
    
    var user: UserModel?
    let tagService: TagService = TagService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
        
        titleLabel = GSLabel(color: .gray, fontSize: 15.0, isBold: false)
        titleLabel.stringValue = "Add Tag"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view).offset(15)
        }
        
        tagTextField = GSTextField(placeholder: "Tag name", borderColor: bgColor, radius: 15)
        self.view.addSubview(tagTextField)
        tagTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.left.equalTo(self.view).offset(15)
            make.width.equalTo(168)
            make.height.equalTo(28)
        }
        
        addButton = GSButton(title: "Add", textColor: NSColor(hue:0.00, saturation:0.00, brightness:1.00, alpha:1.00), backgroundColor: bgColor, borderColor: NSColor(hue:0.40, saturation:0.98, brightness:0.73, alpha:1.00), radius: 15)
        addButton.target = self
        addButton.action = #selector(addTag)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.right.equalTo(self.view).offset(-15)
            make.width.equalTo(98)
            make.height.equalTo(28)
        }
    }
    
    override func loadView() {
        self.view = NSView()
    }
    
    @objc func addTag() {
        if let user = self.user {
            let tag = tagTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if (tag.count > 0) {
                tagService.add(userId: user.id, name: tag)
                NSApp.mainWindow?.endSheet(self.view.window!)
            }
        }
    }
}
