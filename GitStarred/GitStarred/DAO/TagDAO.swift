//
//  TagDao.swift
//  GitStarred
//
//  Created by peter on 2018/3/7.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import SQLite

class TagDAO {
    private var conn: Connection!
    
    private let tag = Table("tag")
    private let id = Expression<Int64>("id")
    private let userId = Expression<Int64>("user_id")
    private let name = Expression<String>("name")
    
    init() {
        conn = BaseDAO.instance.conn
        
        do {
            try conn!.run(tag.create(ifNotExists: true) { (table) in
                table.column(id, primaryKey: true)
                table.column(userId)
                table.column(name)
                table.unique(userId, name)
            })
        } catch {
            print("Tag table create error")
        }
    }
    
    func insert(userId: Int64, name: String) -> TagModel? {
        do {
            let insert = tag.insert(self.userId <- userId, self.name <- name)
            let rowid = try conn!.run(insert)
            
            return TagModel(id: rowid, userId: userId, name: name)
        } catch {
            print("Insert tag error \(error)")
            
            return nil
        }
    }
    
    func findByUserId(userId: Int64) -> [TagModel] {
        var tags: [TagModel] = []
        do {
            for tag in try conn!.prepare("select t1.id, t1.user_id, t1.name, (select count(t2.repo_id) from tag_and_repo t2 where t1.id=t2.tag_id) from tag t1 where t1.user_id=\(userId) order by t1.id desc;") {
                tags.append(TagModel(id: tag[0]! as! Int64, userId: tag[1]! as! Int64, name: tag[2]! as! String, repoCount: tag[3]! as! Int64))
            }
        } catch  {
            print("Find tag by userId error \(error)")
        }
        return tags
    }
    
    func findByNotInIds(ids: [Int64]) -> [TagModel] {
        var tags: [TagModel] = []
        do {
            for tag in try conn!.prepare(tag.filter(!ids.contains(self.id)).order(self.id.desc)) {
                tags.append(TagModel(id: tag[self.id], userId: tag[self.userId], name: tag[self.name]))
            }
        } catch  {
            print("Find tag by not in ids error \(error)")
        }
        return tags
    }
}
