//
//  PreferenceUserView.swift
//  GitStarred
//
//  Created by peter on 2018/2/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class PreferenceUserView: NSView {
    
    var userLabel: GSLabel!
    var userIcon: NSImageView!
    var userTextField: GSTextField!
    var loginButton: GSButton!
    var logoutButton: GSButton!
    var topOffset: CGFloat = 0.0
    var currentUser: UserModel?
    let sessionService: SessionService = SessionService()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    convenience init(toolbarHeight: CGFloat) {
        self.init()
        
        topOffset = toolbarHeight + 20.0
        
        userIcon = NSImageView()
        userIcon.image = NSImage(named: NSImage.Name("User"))
        userIcon.image?.size = NSSize(width: 16, height: 16)
        self.addSubview(userIcon)
        userIcon.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topOffset)
            make.left.equalTo(self).offset(20)
        }
        
        userLabel = GSLabel(color: .gray1, fontSize: 14.0)
        userLabel.isHidden = true
        userLabel.lineBreakMode = .byTruncatingTail
        userLabel.sizeToFit()
        self.addSubview(userLabel)
        userLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topOffset - 2)
            make.left.equalTo(userIcon.snp.right).offset(15)
        }
        
        userTextField = GSTextField(placeholder: "Username", radius: 17)
        userTextField.isHidden = true
        self.addSubview(userTextField)
        userTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topOffset - 6)
            make.left.equalTo(userIcon.snp.right).offset(15)
            make.width.equalTo(188)
            make.height.equalTo(28)
        }
    
        loginButton = GSButton(title: "Login", textColor: NSColor(hue:0.00, saturation:0.00, brightness:1.00, alpha:1.00), backgroundColor: NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00), borderColor: NSColor(hue:0.40, saturation:0.98, brightness:0.73, alpha:1.00), radius: 14)
        loginButton.target = self
        loginButton.isHidden = true
        loginButton.action = #selector(login)
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topOffset - 6)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(128)
            make.height.equalTo(28)
        }
        
        logoutButton = GSButton(title: "Logout", textColor: NSColor(hue:0.96, saturation:0.51, brightness:0.98, alpha:1.00), backgroundColor: NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00), borderColor: NSColor(hue:0.96, saturation:0.51, brightness:0.98, alpha:1.00), radius: 14)
        logoutButton.target = self
        logoutButton.isHidden = true
        logoutButton.action = #selector(logout)
        self.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topOffset - 6)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(128)
            make.height.equalTo(28)
        }
        
        if let user = sessionService.getUser() {
            self.currentUser = user
            renderToggle(isLogined: true)
            userLabel.stringValue = user.name
        } else {
            renderToggle(isLogined: false)
        }
    }
    
    func renderToggle(isLogined: Bool) {
        if (isLogined) {
            userLabel.isHidden = false
            userTextField.isHidden = true
            loginButton.isHidden = true
            logoutButton.isHidden = false
            userTextField.stringValue = ""
        } else {
            userLabel.isHidden = true
            userTextField.isHidden = false
            loginButton.isHidden = false
            logoutButton.isHidden = true
            userLabel.stringValue = ""
        }
    }
    
    @objc func login() {
        let username = userTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if (username.count > 0) {
            sessionService.login(username: username)
            renderToggle(isLogined: true)
            userLabel.stringValue = username
        }
    }
    
    @objc func logout() {
        if let _ = self.currentUser {
            sessionService.logout()
            renderToggle(isLogined: false)
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.16, alpha:1.00).cgColor
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
