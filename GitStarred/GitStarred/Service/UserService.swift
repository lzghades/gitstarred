//
//  UserService.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

class UserService {
    func login(name: String) {
        let userDao = UserDAO()
        _ = userDao.insert(_name: name)
    }
    
    func logout(id: Int64) {
        let userDao = UserDAO()
        userDao.delete(_id: id)
    }
    
    func getUser() -> UserModel? {
        let userDao = UserDAO()
        return userDao.findFirst()
    }
}
