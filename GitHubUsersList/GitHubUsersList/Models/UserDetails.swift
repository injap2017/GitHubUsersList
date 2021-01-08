//
//  UserDetails.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation

class UserDetails: Codable {
    var id: Int
    var login: String
    var avatar_url: String
    var url: String
    var html_url: String
    var name: String
    var company: String
    var blog: String
    var followers: Int
    var following: Int
    var notes: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case avatar_url = "avatar_url"
        case url = "url"
        case html_url = "html_url"
        case name = "name"
        case company = "company"
        case blog = "blog"
        case followers = "followers"
        case following = "following"
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            login = try container.decodeIfPresent(String.self, forKey: .login) ?? ""
            avatar_url = try container.decodeIfPresent(String.self, forKey: .avatar_url) ?? ""
            url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
            html_url = try container.decodeIfPresent(String.self, forKey: .html_url) ?? ""
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            company = try container.decodeIfPresent(String.self, forKey: .company) ?? ""
            blog = try container.decodeIfPresent(String.self, forKey: .blog) ?? ""
            followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
            following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
            notes = ""
        }
    }
    
    init() {
        id = -1
        login = ""
        avatar_url = ""
        url = ""
        html_url = ""
        name = ""
        company = ""
        blog = ""
        followers = 0
        following = 0
        notes = ""
    }
}
