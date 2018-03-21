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
    private let syncDate = Expression<Int64>("sync_date")
    
    init() {
        conn = BaseDAO.instance.conn
        
        do {
            try conn!.run(user.create(ifNotExists: true) { (table) in
                table.column(id, primaryKey: true)
                table.column(name, unique: true)
                table.column(syncDate, defaultValue: Int64(Date().timeIntervalSince1970))
            })
        } catch {
            print("User table create error")
        }
    }
    
    func insert(name: String) -> UserModel? {
        do {
            let now = Int64(Date().timeIntervalSince1970)
            let insert = user.insert(self.name <- name, self.syncDate <- now)
            let rowid = try conn!.run(insert)
            
            return UserModel(id: rowid, name: name, syncDate: now)
        } catch {
            print("Insert user error \(error)")
            
            return nil
        }
    }
    
    func updateSyncDate(id: Int64, date: Int64) {
        do {
            let user = self.user.filter(self.id == id)
            try conn!.run(user.update(syncDate <- date))
        } catch {
            print("Update syncDate error \(error)")
        }
    }
    
    func findById(id: Int64) -> UserModel? {
        do {
            for user in try conn!.prepare(user.filter(self.id == id)) {
                return UserModel(id: user[self.id], name: user[self.name], syncDate: user[self.syncDate])
            }
        } catch  {
            print("Find user by id error \(error)")
        }
        
        return nil
    }
    
    func findByName(name: String) -> UserModel? {
        do {
            for user in try conn!.prepare(user.filter(self.name == name)) {
                return UserModel(id: user[self.id], name: user[self.name], syncDate: user[self.syncDate])
            }
        } catch  {
            print("Find user by name error \(error)")
        }
        
        return nil
    }
}
