//
//  Starred.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import ObjectMapper

class RepoModel: ImmutableMappable {
    var id: Int64
    var name: String
    var description: String
    var url: String
    var updateDate: String
    var ownerName: String
    var ownerAvatar: String
    
    required init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        description = (try? map.value("description")) ?? "No Description"
        url = try map.value("html_url")
        updateDate = try map.value("updated_at")
        ownerName = try map.value("owner.login")
        ownerAvatar = try map.value("owner.avatar_url")
    }
    
    init(id: Int64, name: String, description: String, url: String, updateDate: String, ownerName: String, ownerAvatar: String) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.updateDate = updateDate
        self.ownerName = ownerName
        self.ownerAvatar = ownerAvatar
    }
}
