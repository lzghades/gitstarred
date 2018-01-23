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
    
    required init(map: Map) throws {
        id = try map.value("id")
    }
    
    func mapping(map: Map) {
        id >>> map["id"]
    }
}
