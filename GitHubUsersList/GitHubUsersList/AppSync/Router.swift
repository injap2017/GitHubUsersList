//
//  Router.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case getUser(String)
    case getUsers(Int, Int)
    
    var baseURL: URL {
        return URL.init(string: "https://api.github.com")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUser: return .get
        case .getUsers: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUser(let username): return "users/\(username)"
        case .getUsers: return "users"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case .getUser(_):
            break
        case .getUsers(let since, let per_page):
            let parameters = ["since": "\(since)", "per_page": "\(per_page)"]
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}
