//
//  UserService.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

class UserService {
    
    let userDao: UserDAO = UserDAO()
    
//    func login(name: String) {
//        let userDao = UserDAO()
//        _ = userDao.insert(_name: name)
//    }
//
//    func logout(id: Int64) {
//        let userDao = UserDAO()
//        userDao.delete(_id: id)
//    }
    
    func create(username: String) -> UserModel? {
        return userDao.insert(name: username)
    }
    
    func getUser(username: String) -> UserModel? {
        return userDao.findByName(name: username)
    }
    
    func getUser(id: Int64) -> UserModel? {
        return userDao.findById(id: id)
    }
}
