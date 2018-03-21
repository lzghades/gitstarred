//
//  RightPanelView.swift
//  GitStarred
//
//  Created by peter on 2018/1/24.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import WebKit

class RightPanelView: NSView, ListDelegate {
    
    var contentView: NSView!
    var ownerName: GSLabel!
    var repoName: GSLabel!
    var webView: WKWebView!
    var indicatorView: KRActivityIndicatorView!
    var tagView: GSTagView!
    var currentUser: UserModel?
    
    let githubService: GitHubService = GitHubService()
    let tagService: TagService = TagService()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hue:0.11, saturation:0.01, brightness:0.97, alpha:1.00).cgColor
        
        let preferences = WKPreferences()
        preferences.javaEnabled = false
        preferences.javaScriptCanOpenWindowsAutomatically = false
        preferences.javaScriptEnabled = false
        preferences.plugInsEnabled = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.suppressesIncrementalRendering = false
        
        contentView = NSView()
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(20)
            make.right.bottom.equalTo(self).offset(-20)
        }
        
        repoName = GSLabel(color: .black, fontSize: 16.0)
        repoName.sizeToFit()
        ownerName = GSLabel(color: .grayDark, fontSize: 12.0)
        ownerName.sizeToFit()
        contentView.addSubview(repoName)
        contentView.addSubview(ownerName)
        
        repoName.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(contentView).offset(0)
        }
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.setValue(true, forKey: "drawsTransparentBackground")
        contentView.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(50)
            make.right.bottom.left.equalTo(contentView).offset(0)
        }
        
        indicatorView = KRActivityIndicatorView(frame: CGRect.zero)
        indicatorView.color = NSColor(hue:0.00, saturation:0.00, brightness:0.15, alpha:1.00)
        indicatorView.type = .ballClipRotatePulse
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(32)
        }
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func selectRepo(repo: RepoModel) {
        contentView.isHidden = true
        indicatorView.startAnimating()
        githubService.getReadme(username: repo.ownerName, repoName: repo.name) { (data) in
            self.webView.loadHTMLString(data, baseURL: URL(string: repo.url))
            self.repoName.stringValue = repo.name
            self.ownerName.stringValue = repo.ownerName
            self.indicatorView.stopAnimating()
            self.contentView.isHidden = false
        }
        
        print(tagService.getTagsByRepoId(repoId: repo.id))
    }
}
