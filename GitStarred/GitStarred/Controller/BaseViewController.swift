//
//  BaseViewController.swift
//  GitStarred
//
//  Created by peter on 2018/1/23.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa
import SnapKit

class BaseViewController: NSViewController, NSSplitViewDelegate, RefreshListDelegate {
    
    var splitView: NSSplitView!
    var leftPanel: LeftPanelView!
    var middlePanel: MiddlePanelView!
    var rightPanel: RightPanelView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        splitView = NSSplitView()
        splitView.isVertical = true
        splitView.dividerStyle = .thin
        splitView.delegate = self
        
        leftPanel = LeftPanelView()
        leftPanel.delegate = self
        
        middlePanel = MiddlePanelView()
        
        rightPanel = RightPanelView()
        
        splitView.insertArrangedSubview(leftPanel, at: 0)
        splitView.insertArrangedSubview(middlePanel, at: 1)
        splitView.insertArrangedSubview(rightPanel, at: 2)
        
        self.view.addSubview(splitView)
        
        layout()
        splitView.adjustSubviews()
    }
    
    func layout() {
        splitView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
        }
        
        leftPanel.snp.makeConstraints { (make) in
            make.top.equalTo(splitView).offset(0)
            make.bottom.equalTo(splitView).offset(0)
            make.left.equalTo(splitView).offset(0)
            make.width.greaterThanOrEqualTo(200)
        }
        middlePanel.snp.makeConstraints { (make) in
            make.top.equalTo(splitView).offset(0)
            make.bottom.equalTo(splitView).offset(0)
            make.width.greaterThanOrEqualTo(350)
        }
        rightPanel.snp.makeConstraints { (make) in
            make.top.equalTo(splitView).offset(0)
            make.bottom.equalTo(splitView).offset(0)
            make.width.greaterThanOrEqualTo(200)
        }
    }
    
    func splitView(_ splitView: NSSplitView, constrainSplitPosition proposedPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        print(proposedPosition)
//        print(splitView.arrangedSubviews[0].frame)

        return proposedPosition
    }
    
    func refreshList(finished: @escaping () -> Void) {
        middlePanel.refresh(finished: finished)
    }
    
    override func keyDown(with event: NSEvent) {
        if ((event.modifierFlags.rawValue & NSEvent.ModifierFlags.deviceIndependentFlagsMask.rawValue) == NSEvent.ModifierFlags.command.rawValue && event.keyCode == 15) {
            leftPanel.refreshData()
        }
    }
}
