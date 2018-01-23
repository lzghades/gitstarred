//
//  GithubService.swift
//  GitStarred
//
//  Created by peter on 2018/1/19.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Foundation
import MoyaSugar
import Moya_ObjectMapper

class GitHubService {
    let provider = MoyaSugarProvider<GitHubAPI>()
    
    init() {
        
    }
    
    func getStarreds(success: @escaping ([StarredModel]) -> Void) {
        provider.request(.starred(user: "lzghades")) { (result) in
            switch result {
            case let .success(resp):
                do {
                    let starreds = try resp.mapArray(StarredModel.self)
                    success(starreds)
                } catch {
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
