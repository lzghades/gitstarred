//
//  TagService.swift
//  GitStarred
//
//  Created by peter on 2018/3/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

class TagService {
    
    let tagDao: TagDAO = TagDAO()
    let tagAndRepoDao: TagAndRepoDAO = TagAndRepoDAO()
    
    func add(userId: Int64, name: String) -> TagModel? {
        return tagDao.insert(userId: userId, name: name)
    }
    
    func getAll(userId: Int64) -> [TagModel] {
        return tagDao.findByUserId(userId: userId)
    }
    
    func excludTags(repoId: Int64) -> [TagModel] {
        let repoTags = tagAndRepoDao.findTagIdsByRepoId(repoId: repoId)
        return tagDao.findByNotInIds(ids: repoTags)
    }
    
    func addRepoIntoTag(tagId: Int64, repoId: Int64) {
        tagAndRepoDao.insert(tagId: tagId, repoId: repoId)
    }
    
    func getTagsByRepoId(repoId: Int64) -> [TagModel] {
        return tagAndRepoDao.findTagsByRepoId(repoId: repoId)
    }
}

