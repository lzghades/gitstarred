//
//  LeftPanelView.swift
//  GitStarred
//
//  Created by peter on 2018/1/24.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class LeftPanelView: NSView, IconItemDelegate {
    
    var profileLabel: GSLabel!
    var logoImageView: NSImageView!
    var allButton: GSIconItem!
    var countBadge: GSBadge!
    var indicatorView: KRActivityIndicatorView!
    var toolbar: NSView!
    var syncButton: GSIconButton!
    var addTagButtton: GSIconButton!
    var tagScrollView: GSScrollView!
    var tagView: GSTagView!
    
    var addTagWindow: NSWindow!
    var addTagViewController: AddTagViewController!
    var delegate: SyncReposDelegate!
    let sessionService: SessionService = SessionService()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.12, alpha:1.00).cgColor
        
        renderLogo()
        renderAllButton()
        renderTagScrollView()
        renderToolbar()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func renderLogo() {
        logoImageView = NSImageView()
        logoImageView.setFrameSize(NSSize(width: 48, height: 48))
        logoImageView.image = NSImage(named: NSImage.Name("WhiteLogo"))
        self.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.right.equalTo(self).offset(0)
        }
    }
    
    func renderProfile(user: UserModel?) {
        profileLabel = GSLabel(color: .grayDark, fontSize: 10.0)
        
        if let user = user {
            let now = Int64(Date().timeIntervalSince1970)
            let diff = now - user.syncDate
            var timeStr = "Last Sync: "
            
            let date = Date(timeIntervalSince1970: TimeInterval(user.syncDate))
            let dformatter = DateFormatter()
            if (diff <= 60*60*24) {
                dformatter.dateFormat = "HH:mm"
            } else if (diff > 60*60*24 && diff <= 60*60*24*364) {
                dformatter.dateFormat = "MM/dd HH:mm"
            } else {
                dformatter.dateFormat = "yyyy/MM/dd HH:mm"
            }
            
            timeStr += dformatter.string(from: date)
            profileLabel.stringValue = "\(user.name!)  \(timeStr)"
        } else {
            profileLabel.stringValue = "Not Login"
        }
        
        profileLabel.sizeToFit()
        profileLabel.alignment = NSTextAlignment.center
        
        self.addSubview(profileLabel)
        profileLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(4)
            make.left.right.equalTo(self).offset(0)
        }
    }
    
    func renderTagScrollView() {
        tagScrollView = GSScrollView()
        
        self.addSubview(tagScrollView)
        tagScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.allButton.snp.bottom).offset(20)
            make.right.left.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-34)
        }
    }
    
    func renderTags() {
        if let user = sessionService.getSession() {
            tagView = GSTagView(userId: user.id, tagColor: NSColor(hue:0.00, saturation:0.00, brightness:0.19, alpha:1.00), tagBg: NSColor(hue:0.12, saturation:0.03, brightness:0.94, alpha:1.00))
            tagView.viewLayout(maxWidth: tagScrollView.frame.size.width)
            
            tagScrollView.documentView = tagView
            tagView.snp.makeConstraints({ (make) in
                make.top.right.left.equalTo(tagScrollView).offset(0)
                make.height.equalTo(tagView.frame.size.height)
            })
        }
    }
    
    func renderAllButton() {
        allButton = GSIconItem(icon: NSImage(named: NSImage.Name.listViewTemplate)!, label: "All Items", selected: false)
        allButton.delegate = self

        countBadge = GSBadge(color: NSColor(hue:0.00, saturation:0.00, brightness:0.96, alpha:1.00), bgColor: NSColor(hue:0.00, saturation:0.00, brightness:0.12, alpha:1.00))
        countBadge.stringValue = "0"
        countBadge.sizeToFit()

        self.addSubview(allButton)
        self.addSubview(countBadge)

        allButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(36)
            make.left.right.equalTo(self).offset(0)
            make.height.equalTo(allButton.frame.size.height)
        }

        countBadge.snp.makeConstraints { (make) in
            make.top.equalTo(allButton.snp.top).offset(6)
            make.right.equalTo(self).offset(-8)
        }
    }
    
    func renderToolbar() {
        toolbar = NSView()
        
        syncButton = GSIconButton(icon: NSImage(named: NSImage.Name("Refresh"))!)
        syncButton.target = self
        syncButton.action = #selector(syncRepos)
        
        indicatorView = KRActivityIndicatorView(frame: CGRect.zero)
        indicatorView.color = NSColor(hue:0.00, saturation:0.00, brightness:1.00, alpha:1.00)
        indicatorView.type = .ballClipRotatePulse
        
        addTagButtton = GSIconButton(icon: NSImage(named: NSImage.Name("Add"))!)
        addTagButtton.target = self
        addTagButtton.action = #selector(addTag)
        
        toolbar.addSubview(syncButton)
        toolbar.addSubview(indicatorView)
        toolbar.addSubview(addTagButtton)
        self.addSubview(toolbar)
        
        toolbar.snp.makeConstraints { (make) in
            make.right.bottom.left.equalTo(self).offset(0)
            make.height.equalTo(32)
        }
        syncButton.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.bottom.equalTo(toolbar).offset(-12)
            make.left.equalTo(toolbar).offset(16)
        }
        indicatorView.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.bottom.equalTo(toolbar).offset(-12)
            make.left.equalTo(toolbar).offset(16)
        }
        addTagButtton.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.bottom.equalTo(toolbar).offset(-12)
            make.right.equalTo(toolbar).offset(-16)
        }
    }
    
    func reRenderTagView() {
        self.tagView.viewLayout(maxWidth: self.tagScrollView.frame.width)
    }
    
    func iconItemClick() {
        delegate?.loadRepos()
    }
    
    @objc func syncRepos() {
        if let user = sessionService.getSession() {
            self.delegate.sync(user: user)
        }
    }
    
    @objc func addTag() {
        if let user = sessionService.getSession() {
            addTagViewController = AddTagViewController()
            addTagViewController.user = user
            addTagWindow = NSWindow(contentViewController: addTagViewController)
            addTagWindow.setContentSize(NSSize(width: 368, height: 120))
            
            NSApp.mainWindow?.beginSheet(addTagViewController.view.window!, completionHandler: nil)
        }
    }
    
    func beginSyncRepos(username: String) {
        syncButton.isHidden = true
        indicatorView.startAnimating()
        
        profileLabel.stringValue = "\(username) syncing..."
    }
    
    func endSyncRepos(username: String, now: Int64) {
        indicatorView.stopAnimating()
        syncButton.isHidden = false
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(now))
        
        profileLabel.stringValue = "\(username) Last Sync: \(dformatter.string(from: date))"
    }
}
