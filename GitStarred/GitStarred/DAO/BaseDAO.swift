//
//  BaseDB.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import SQLite

class BaseDAO {
    static let instance = BaseDAO()
    var conn: Connection?
    
    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .applicationSupportDirectory, .userDomainMask, true
                ).first! + "/" + Bundle.main.bundleIdentifier!
            
            try FileManager.default.createDirectory(
                atPath: path, withIntermediateDirectories: true, attributes: nil
            )
        
            conn = try Connection("\(path)/gitstarred.sqlite3")
        } catch {
            conn = nil
        }
    }
}
