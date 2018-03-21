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
    var data: Array<RepoModel> = []
    var page: Int = 1
    
    init() {}
    
    private func recursion(username: String, success: @escaping ([RepoModel]) -> Void) {
        provider.request(.starred(user: username, page: self.page)) { (result) in
            switch result {
            case let .success(resp):
                do {
                    let starreds = try resp.mapArray(RepoModel.self)
                    if (starreds.count > 0) {
                        self.data += starreds
                        self.page += 1
                        self.recursion(username: username, success: success)
                    } else {
                        self.page = 1
                        success(self.data)
                        return
                    }
                } catch {
                    print("Json mapping error \(error)")
                }
            case let .failure(error):
                print("Request error \(error)")
            }
        }
    }
    
    func syncRepos(username: String, success: @escaping ([RepoModel]) -> Void) {
        recursion(username: username, success: success)
    }
    
    func getReadme(username: String, repoName: String, success: @escaping (String) -> Void) {
        provider.request(.readme(user: username, repo: repoName)) { (result) in
            switch result {
            case let .success(resp):
                do {
                    let readme = try resp.mapString()
                    success(readme)
                } catch {
                    print("Html mapping error \(error)")
                }
            case let .failure(error):
                print("Request error \(error)")
            }
        }
    }
}
