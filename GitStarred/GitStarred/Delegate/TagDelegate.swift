//
//  TagDelegate.swift
//  GitStarred
//
//  Created by peter on 2018/3/15.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

protocol TagDelegate {
    func addRepoIntoTag(tagId: Int64, repoId: Int64)
}
