//
//  SessionDAO.swift
//  GitStarred
//
//  Created by peter on 2018/2/8.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import SQLite

class SessionDAO {
    private var conn: Connection!
    
    private let session = Table("session")
    private let id = Expression<Int64>("id")
    private let userId = Expression<Int64>("user_id")
    
    init() {
        conn = BaseDAO.instance.conn
        
        do {
            try conn!.run(session.create(ifNotExists: true) { (table) in
                table.column(id, primaryKey: true)
                table.column(userId, unique: true)
            })
        } catch {
            print("Session table create error")
        }
    }

    func delete() {
        do {
            try conn.run(session.delete())
        } catch {
            print("Delete session error \(error)")
        }
    }

    func get() -> SessionModel? {
        do {
            if let query = try conn.pluck(session) {
                return SessionModel(id: query[self.id], userId: query[self.userId])
            }
        } catch {
            print("Get session error \(error)")
        }
        
        return nil
    }
    
    func insert(userId: Int64) {
        do {
            try conn.run(session.delete())
            let insert = session.insert(self.userId <- userId)
            try conn.run(insert)
        } catch {
            print("Insert session error \(error)")
        }
    }
}
