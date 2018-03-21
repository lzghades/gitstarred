//
//  TagModel.swift
//  GitStarred
//
//  Created by peter on 2018/2/6.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import ObjectMapper

class TagModel {
    var id: Int64
    var userId: Int64
    var name: String
    var repoCount: Int64
    
    init(id: Int64, userId: Int64, name: String, repoCount: Int64 = 0) {
        self.id = id
        self.userId = userId
        self.name = name
        self.repoCount = repoCount
    }
}
