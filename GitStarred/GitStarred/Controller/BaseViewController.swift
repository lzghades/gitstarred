//
//  BaseViewController.swift
//  GitStarred
//
//  Created by peter on 2018/1/23.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import SnapKit

class BaseViewController: NSViewController, NSSplitViewDelegate, SyncReposDelegate {
    
    var splitView: NSSplitView!
    var leftPanel: LeftPanelView!
    var middlePanel: MiddlePanelView!
    var rightPanel: RightPanelView!
    var authWindow: NSWindow!
    var authViewController: AuthViewController!
    
    let githubService: GitHubService = GitHubService()
    let sessionService: SessionService = SessionService()
    let userService: UserService = UserService()
    let repoService: RepoService = RepoService()
    var currentUser: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        splitView = NSSplitView()
        splitView.isVertical = true
        splitView.dividerStyle = .thin
        splitView.delegate = self
        
        leftPanel = LeftPanelView()
        leftPanel.delegate = self
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.checkSession()
        }
        
        middlePanel = MiddlePanelView()
        
        rightPanel = RightPanelView()
        
        middlePanel.tableView.listDelegate = rightPanel
        
        splitView.insertArrangedSubview(leftPanel, at: 0)
        splitView.insertArrangedSubview(middlePanel, at: 1)
        splitView.insertArrangedSubview(rightPanel, at: 2)
        
        self.view.addSubview(splitView)
        
        layout()
        splitView.adjustSubviews()
    }
    
    func layout() {
        splitView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view).offset(0)
        }
        
        leftPanel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(splitView).offset(0)
            make.width.greaterThanOrEqualTo(200)
        }
        middlePanel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(splitView).offset(0)
            make.width.greaterThanOrEqualTo(350)
        }
        rightPanel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(splitView).offset(0)
            make.width.greaterThanOrEqualTo(200)
        }
    }
    
    func splitView(_ splitView: NSSplitView, constrainSplitPosition proposedPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {

        if (dividerIndex == 0) {
            self.leftPanel.reRenderTagView()
        } else if (dividerIndex == 1) {
            self.middlePanel.reload()
        }
        
        return proposedPosition
    }
    
    func loadRepos() {
        if let user = self.currentUser {
            let repos: [RepoModel] = self.repoService.getAll(userId: user.id)
            self.reposUpdate(repos: repos)
        }
    }
    
    func sync(user: UserModel?) {
        self.currentUser = user
        if let user = user {
            leftPanel.beginSyncRepos(username: user.name)
            githubService.syncRepos(username: user.name) { (repos) -> Void in
                self.repoService.sync(userId: user.id, repos: repos)
                
                let now = Int64(Date().timeIntervalSince1970)
                self.leftPanel.endSyncRepos(username: user.name!, now: now)
                self.userService.updateSyncDate(id: user.id, date: now)
                
                self.reposUpdate(repos: repos)
            }
        }
    }
    
    private func reposUpdate(repos: [RepoModel]) {
        self.middlePanel.refresh(repos: repos)
        self.leftPanel.countBadge.stringValue = "\(repos.count)"
    }
    
    func checkSession() {
        if let user = sessionService.getSession() {
            self.currentUser = user
            self.leftPanel.allButton.selected()
            self.leftPanel.renderTags()
        } else {
            authViewController = AuthViewController()
            authViewController.delegate = self
            authWindow = NSWindow(contentViewController: authViewController)
            authWindow.setContentSize(NSSize(width: 480, height: 120))
            
            NSApp.mainWindow?.beginSheet(authViewController.view.window!, completionHandler: nil)
        }
        
        leftPanel.renderProfile(user: self.currentUser)
    }
    
    override func keyDown(with event: NSEvent) {
        if ((event.modifierFlags.rawValue & NSEvent.ModifierFlags.deviceIndependentFlagsMask.rawValue) == NSEvent.ModifierFlags.command.rawValue && event.keyCode == 15) {
            if let user = self.currentUser {
                sync(user: user)
            }
        }
    }
}
