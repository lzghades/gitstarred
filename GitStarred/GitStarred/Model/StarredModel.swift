//
//  Starred.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import ObjectMapper

class StarredModel: ImmutableMappable {
    var id: Int
    var name: String
    var description: String
    
    required init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        description = try map.value("description")
    }
    
    func mapping(map: Map) {
        id >>> map["id"]
        name >>> map["name"]
        description >>> map["description"]
    }
}
