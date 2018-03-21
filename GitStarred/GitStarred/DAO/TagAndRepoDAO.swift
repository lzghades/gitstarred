//
//  TagAndRepoDAO.swift
//  GitStarred
//
//  Created by peter on 2018/3/12.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import SQLite

class TagAndRepoDAO {
    private var conn: Connection!
    
    private let tagAndRepo = Table("tag_and_repo")
    private let id = Expression<Int64>("id")
    private let tagId = Expression<Int64>("tag_id")
    private let repoId = Expression<Int64>("repo_id")
    
    init() {
        conn = BaseDAO.instance.conn
        
        do {
            try conn!.run(tagAndRepo.create(ifNotExists: true) { (table) in
                table.column(id, primaryKey: true)
                table.column(tagId)
                table.column(repoId)
                table.unique(tagId, repoId)
            })
        } catch {
            print("TagAndRepo table create error")
        }
    }
    
    func findTagIdsByRepoId(repoId: Int64) -> [Int64] {
        var tags: [Int64] = []
        do {
            for tag in try conn!.prepare(tagAndRepo.filter(self.repoId == repoId)) {
                tags.append(tag[self.tagId])
            }
        } catch  {
            print("Find tagids by repoId error \(error)")
        }
        return tags
    }
    
    func insert(tagId: Int64, repoId: Int64) {
        do {
            let insert = tagAndRepo.insert(self.tagId <- tagId, self.repoId <- repoId)
            try conn!.run(insert)
        } catch {
            print("Insert repo into tag error \(error)")
        }
    }
    
    func findTagsByRepoId(repoId: Int64) -> [TagModel] {
        var tags: [TagModel] = []
        do {
            for tag in try conn!.prepare("select t1.id, t1.user_id, t1.name from tag t1, tag_and_repo t2 where t1.id=t2.tag_id and t2.repo_id=\(repoId);") {
                tags.append(TagModel(id: tag[0] as! Int64, userId: tag[1] as! Int64, name: tag[2] as! String))
            }
        } catch  {
            print("Find tags by repoId error \(error)")
        }
        return tags
    }
}
