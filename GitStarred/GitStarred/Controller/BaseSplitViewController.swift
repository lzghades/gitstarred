//
//  BaseSplitViewController.swift
//  GitStarred
//
//  Created by peter on 2018/1/17.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Cocoa

class BaseSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let githubService = GitHubService()
        githubService.getStarreds() { (starreds) -> Void in
            print(starreds)
        }
    }
    
}
