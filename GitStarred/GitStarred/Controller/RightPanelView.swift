//
//  RightPanelView.swift
//  GitStarred
//
//  Created by peter on 2018/1/24.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import WebKit

class RightPanelView: NSView {
    
    var webView: WKWebView!

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
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        self.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
        }
        
        var request = URLRequest(url: URL(string: "https://api.github.com/repos/lzghades/gitstarred/readme")!)
        request.addValue("application/vnd.github.v3.html", forHTTPHeaderField: "Accept")
        
//        webView.load(request)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
