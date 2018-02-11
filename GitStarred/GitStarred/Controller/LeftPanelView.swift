//
//  LeftPanelView.swift
//  GitStarred
//
//  Created by peter on 2018/1/24.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class LeftPanelView: NSView, IconItemDelegate {
    
    var dateLabel: GSLabel!
    var logoImageView: NSImageView!
    var allItem: GSIconItem!
    var delegate: RefreshListDelegate!
    var indicatorView: KRActivityIndicatorView!
    var toolbar: NSView!
    var refreshButton: GSIconButton!
    
    var authWindow: NSWindow!
    var authViewController: AuthViewController!
    var currentUser: UserModel?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.00, saturation:0.00, brightness:0.12, alpha:1.00).cgColor
        
        renderLogo()
        renderDate()
        renderAllItem()
        renderToolbar()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.checkSession()
        }
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
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
        }
    }
    
    func renderDate() {
        let now = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        
        dateLabel = GSLabel(color: .grayDark, fontSize: 10.0)
        dateLabel.stringValue = "今天 \(formatter.string(from: now))"
        dateLabel.sizeToFit()
        dateLabel.alignment = NSTextAlignment.center
        
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(3)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
        }
    }
    
    func renderAllItem() {
        allItem = GSIconItem(icon: NSImage(named: NSImage.Name.listViewTemplate)!, label: "All Items", selected: false)
        allItem.delegate = self
        self.addSubview(allItem)
        
        allItem.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(allItem.frame.size.height)
        }
    }
    
    func renderToolbar() {
        toolbar = NSView()
        
        refreshButton = GSIconButton(icon: NSImage(named: NSImage.Name("Refresh"))!)
        refreshButton.target = self
        refreshButton.action = #selector(refreshData)
        
        indicatorView = KRActivityIndicatorView(frame: CGRect.zero)
        indicatorView.color = NSColor(hue:0.00, saturation:0.00, brightness:1.00, alpha:1.00)
        indicatorView.type = .ballClipRotatePulse
        
        toolbar.addSubview(refreshButton)
        toolbar.addSubview(indicatorView)
        self.addSubview(toolbar)
        
        toolbar.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.height.equalTo(32)
        }
        refreshButton.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.bottom.equalTo(toolbar).offset(-12)
            make.left.equalTo(toolbar).offset(16)
        }
        indicatorView.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.bottom.equalTo(toolbar).offset(-12)
            make.left.equalTo(toolbar).offset(16)
        }
    }
    
    func iconItemClick() {
//        delegate?.refreshList(finished: {
//            
//        })
    }
    
    @objc func refreshData() {
        refreshButton.isHidden = true
        indicatorView.startAnimating()
        
        let finished = {
            self.indicatorView.stopAnimating()
            self.refreshButton.isHidden = false
        }
        
        delegate?.refreshList(finished: finished)
    }
    
    func checkSession() {
        let sessionService = SessionService()
        if let user = sessionService.getUser() {
            self.currentUser = user
        } else {
            authViewController = AuthViewController()
            authWindow = NSWindow(contentViewController: authViewController)
            authWindow.setContentSize(NSSize(width: 480, height: 120))
            
            NSApp.mainWindow?.beginSheet(authViewController.view.window!, completionHandler: nil)
        }
    }
}
