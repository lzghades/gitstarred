//
//  SessionModel.swift
//  GitStarred
//
//  Created by peter on 2018/2/6.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

class SessionModel {
    var id: Int64!
    var userId: Int64!
    
    init(id: Int64, userId: Int64) {
        self.id = id
        self.userId = userId
    }
}
