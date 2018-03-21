//
//  RepoService.swift
//  GitStarred
//
//  Created by peter on 2018/3/5.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

class RepoService {
    
    let repoDao: RepoDAO = RepoDAO()
    
    func sync(userId: Int64, repos: [RepoModel]) {
        repoDao.deleteByUserId(userId: userId)
        
        for repo in repos {
            repoDao.insert(userId: userId, repo: repo)
        }
    }
    
    func getAll(userId: Int64) -> [RepoModel] {
        return repoDao.findByUserId(userId: userId)
    }
    
    func search(text: String) -> [RepoModel] {
        return repoDao.findByNameOrDescription(text: text)
    }
}
