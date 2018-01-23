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
    
    func insert(_name: String) -> UserModel? {
        do {
            let insert = user.insert(name <- _name)
            let rowid = try conn.run(insert)
            
            return UserModel(_id: rowid, _name: _name)
        } catch {
            print("Insert user error \(error)")
            
            return nil
        }
    }
    
    func delete(_id: Int64) {
        do {
            let _user = user.filter(id == _id)
            try conn.run(_user.delete())
        } catch {
            print("Delete user error \(error)")
        }
    }
    
    func findFirst() -> UserModel? {
        do {
            let query = user.select(id, name).limit(1)
            guard let a = try conn.pluck(query) else {
                return nil
            }

            return UserModel(_id: try a.get(id), _name: try a.get(name))
        } catch {
            return nil
        }
    }
}
