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
    case starred(user: String)
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
        case .starred(let user):
            return .get("/users/\(user)/starred")
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
        case .starred:
            let now = Date()
            
            return [
                "t": Int(now.timeIntervalSince1970)
            ]
        default:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json", "Accept": "application/vnd.github.v3+json"]
    }
}
