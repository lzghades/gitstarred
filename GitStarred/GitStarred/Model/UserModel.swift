//
//  UserModel.swift
//  GitStarred
//
//  Created by peter on 2018/1/19.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

class UserModel {
    var id: Int64!
    var name: String!
    var syncDate: Int64!
    
    init(id: Int64, name: String, syncDate: Int64) {
        self.id = id
        self.name = name
        self.syncDate = syncDate
    }
}
