//
//  Base.swift
//  GitStarred
//
//  Created by peter on 2018/1/10.
//  Copyright © 2018年 l3xlab. All rights reserved.
//

import Moya
import MoyaSugar

enum GitHubAPI {
    case url(URL)
    
    case zen
    case starred(user: String, page: Int)
    case readme(user: String, repo: String)
}

extension GitHubAPI: SugarTargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.github.com")!
        }
    }
    
    var route: Route {
        switch self {
        case .url:
            return .get("")
        case .zen:
            return .get("/zen")
        case .starred(let user, _):
            return .get("/users/\(user)/starred")
        case .readme(let user, let repo):
            return .get("/repos/\(user)/\(repo)/readme")
        }
    }
    
    var url: URL {
        switch self {
        case .url(let url):
            return url
        default:
            return self.defaultURL
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .starred(_, let page):
            let now = Date()
            
            return [
                "t": Int(now.timeIntervalSince1970),
                "per_page": 100,
                "page": page
            ]
        default:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        switch self {
        case .readme:
            return ["Accept": "application/vnd.github.v3.html"]
        default:
            return ["Content-type": "application/json", "Accept": "application/vnd.github.v3+json"]
        }
    }
}
