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
    
    init(_id: Int64, _name: String) {
        id = _id
        name = _name
    }
}
