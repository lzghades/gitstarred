//
//  PreferenceViewController.swift
//  GitStarred
//
//  Created by peter on 2018/1/17.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import SnapKit

class PreferenceViewController: NSViewController {

    var userLabel: GSLabel!
    var userTextField: GSTextField!
    var actionButton: GSButton!
    
    let userService = UserService()
    var user: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        guard let _user = userService.getUser() else {
            userTextField = GSTextField()
            actionButton = GSButton()
            actionButton.title = "登录"
            actionButton.action = #selector(login)

            self.view.addSubview(userTextField)
            self.view.addSubview(actionButton)

            userTextField.snp.makeConstraints { (make) in
                make.top.equalTo(self.view).offset(0)
                make.left.equalTo(self.view).offset(0)
                make.width.equalTo(200)
                make.height.equalTo(30)
            }

            actionButton.snp.makeConstraints { (make) in
                make.top.equalTo(self.view).offset(30)
                make.left.equalTo(self.view).offset(0)
            }
            
            return
        }
        
        user = _user
        
        userLabel = GSLabel()
        userLabel.stringValue = user!.name

        actionButton = GSButton()
        actionButton.title = "登出"
        actionButton.action = #selector(logout)

        self.view.addSubview(userLabel)
        self.view.addSubview(actionButton)

        userLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
        }

        actionButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(30)
            make.left.equalTo(self.view).offset(0)
        }
    }
    
    @objc func login() {
        userService.login(name: userTextField.stringValue)
    }
    
    @objc func logout() {
        userService.logout(id: user!.id)
    }
}
