//
//  UserService.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

class UserService {
    
    let userDao: UserDAO = UserDAO()

    func create(username: String) -> UserModel? {
        return userDao.insert(name: username)
    }
    
    func getUser(username: String) -> UserModel? {
        return userDao.findByName(name: username)
    }
    
    func getUser(id: Int64) -> UserModel? {
        return userDao.findById(id: id)
    }
    
    func updateSyncDate(id: Int64, date: Int64) {
        userDao.updateSyncDate(id: id, date: date)
    }
}
