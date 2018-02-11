//
//  AuthViewController.swift
//  GitStarred
//
//  Created by peter on 2018/2/6.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class AuthViewController: NSViewController {
    
    var titleLabel: GSLabel!
    var userTextField: GSTextField!
    var actionButton: GSButton!
    let bgColor: NSColor = NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bgColor.cgColor
        
        titleLabel = GSLabel(color: .gray1, fontSize: 15.0, isBold: false)
        titleLabel.stringValue = "Login with your name"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view).offset(15)
        }
        
        userTextField = GSTextField(placeholder: "username", borderColor: bgColor, radius: 15)
        self.view.addSubview(userTextField)
        userTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.left.equalTo(self.view).offset(15)
            make.width.equalTo(218)
            make.height.equalTo(28)
        }
        
        actionButton = GSButton(title: "Login", textColor: NSColor(hue:0.00, saturation:0.00, brightness:1.00, alpha:1.00), backgroundColor: bgColor, borderColor: NSColor(hue:0.40, saturation:0.98, brightness:0.73, alpha:1.00), radius: 15)
        actionButton.target = self
        actionButton.action = #selector(login)
        self.view.addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(60)
            make.right.equalTo(self.view).offset(-15)
            make.width.equalTo(98)
            make.height.equalTo(28)
        }
    }
    
    override func loadView() {
        self.view = NSView()
    }
    
    @objc func login() {
        let username = userTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if (username.count > 0) {
            let sessionService = SessionService()
            sessionService.login(username: username)
            
            NSApp.mainWindow?.endSheet(self.view.window!)
        }
    }
}
