//
//  UserDB.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import SQLite

class UserDAO {
    private var conn: Connection!
    
    private let user = Table("user")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    
    init() {
        conn = BaseDAO.instance.conn
        
        do {
            try conn!.run(user.create(ifNotExists: true) { (table) in
                table.column(id, primaryKey: true)
                table.column(name, unique: true)
            })
        } catch {
            print("User table create error")
        }
    }
    
    func insert(name: String) -> UserModel? {
        do {
            let insert = user.insert(self.name <- name)
            let rowid = try conn.run(insert)
            
            return UserModel(id: rowid, name: name)
        } catch {
            print("Insert user error \(error)")
            
            return nil
        }
    }
    
    func findById(id: Int64) -> UserModel? {
        do {
            for user in try conn.prepare(user.filter(self.id == id)) {
                return UserModel(id: user[self.id], name: user[self.name])
            }
        } catch  {
            print("Find user error \(error)")
        }
        
        return nil
    }
    
    func findByName(name: String) -> UserModel? {
        do {
            for user in try conn.prepare(user.filter(self.name == name)) {
                return UserModel(id: user[self.id], name: user[self.name])
            }
        } catch  {
            print("Find user error \(error)")
        }
        
        return nil
    }
}
