//
//  Repo.swift
//  GitStarred
//
//  Created by peter on 2018/3/5.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import SQLite

class RepoDAO {
    private var conn: Connection!
    
    private let repo = Table("repo")
    private let id = Expression<Int64>("id")
    private let userId = Expression<Int64>("user_id")
    private let repoId = Expression<Int64>("repo_id")
    private let name = Expression<String>("name")
    private let description = Expression<String>("description")
    private let url = Expression<String>("url")
    private let updateDate = Expression<String>("update_date")
    private let ownerName = Expression<String>("owner_name")
    private let ownerAvatar = Expression<String>("owner_avatar")
    
    init() {
        conn = BaseDAO.instance.conn
        
        do {
            try conn!.run(repo.create(ifNotExists: true) { (table) in
                table.column(id, primaryKey: true)
                table.column(userId)
                table.column(repoId, unique: true)
                table.column(name)
                table.column(description)
                table.column(url)
                table.column(updateDate)
                table.column(ownerName)
                table.column(ownerAvatar)
            })
        } catch {
            print("Repo table create error")
        }
    }
    
    func update(repo: RepoModel) {
        do {
            let record = self.repo.filter(self.repoId == repo.id)
            
            if (try conn!.run(record.update([
                self.description <- repo.description,
                self.updateDate <- repo.updateDate,
                self.ownerAvatar <- repo.ownerAvatar
                ])) <= 0 ) {
                try conn!.run(self.repo.insert([
                    self.repoId <- repo.id,
                    self.name <- repo.name,
                    self.description <- repo.description,
                    self.url <- repo.url,
                    self.updateDate <- repo.updateDate,
                    self.ownerName <- repo.ownerName,
                    self.ownerAvatar <- repo.ownerAvatar
                ]))
            }
        } catch {
            print("Update repo error \(error)")
        }
    }
    
    func deleteByUserId(userId: Int64) {
        do {
            let userRepos = self.repo.filter(self.userId == userId)
            try conn!.run(userRepos.delete())
        } catch {
            print("Delete repos by \(userId) error \(error)")
        }
    }
    
    func insert(userId: Int64, repo: RepoModel) {
        do {
            try conn!.run(self.repo.insert([
                self.userId <- userId,
                self.repoId <- repo.id,
                self.name <- repo.name,
                self.description <- repo.description,
                self.url <- repo.url,
                self.updateDate <- repo.updateDate,
                self.ownerName <- repo.ownerName,
                self.ownerAvatar <- repo.ownerAvatar
            ]))
        } catch {
            print("Insert repo error \(error)")
        }
    }
    
    func findByUserId(userId: Int64) -> [RepoModel] {
        var repos: [RepoModel] = []
        do {
            for repo in try conn!.prepare(repo.filter(self.userId == userId)) {
                repos.append(RepoModel(id: repo[self.repoId], name: repo[self.name], description: repo[self.description], url: repo[self.url], updateDate: repo[self.updateDate], ownerName: repo[self.ownerName], ownerAvatar: repo[self.ownerAvatar]))
            }
        } catch  {
            print("Find repo by userId error \(error)")
        }
        return repos
    }
    
    func findByNameOrDescription(text: String) -> [RepoModel] {
        var repos: [RepoModel] = []
        do {
            for repo in try conn!.prepare(repo.filter(self.name.like("%\(text)%") || self.description.like("%\(text)%"))) {
                repos.append(RepoModel(id: repo[self.repoId], name: repo[self.name], description: repo[self.description], url: repo[self.url], updateDate: repo[self.updateDate], ownerName: repo[self.ownerName], ownerAvatar: repo[self.ownerAvatar]))
            }
        } catch  {
            print("Search repo error \(error)")
        }
        return repos
    }
}
