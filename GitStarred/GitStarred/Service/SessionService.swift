//
//  SessionService.swift
//  GitStarred
//
//  Created by peter on 2018/2/8.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation

class SessionService {
    
    let sessionDao: SessionDAO = SessionDAO()
    let userService: UserService = UserService()
    
    func getSession() -> UserModel? {
        if let session = sessionDao.get() {
            if let user = userService.getUser(id: session.userId) {
                return user
            }
        }
        
        return nil
    }
    
    func login(username: String) -> UserModel? {
        if let user = userService.getUser(username: username) {
            sessionDao.insert(userId: user.id)
            return UserModel(id: user.id, name: user.name, syncDate: user.syncDate)
        } else {
            if let user = userService.create(username: username) {
                sessionDao.insert(userId: user.id)
                return UserModel(id: user.id, name: user.name, syncDate: user.syncDate)
            }
        }
        
        return nil
    }
    
    func logout() {
        sessionDao.delete()
    }
}
