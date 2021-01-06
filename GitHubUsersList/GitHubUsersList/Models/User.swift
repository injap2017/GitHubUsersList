//
//  User.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int = -1
    var username: String = ""
    var avatar: String = ""
    var url: String = ""
    var htmlURL: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.username <- map["login"]
        self.avatar <- map["avatar_url"]
        self.url <- map["url"]
        self.htmlURL <- map["html_url"]
    }
    
    func copyTo(_ user: User) {
        user.id = self.id
        user.username = self.username
        user.avatar = self.avatar
        user.url = self.url
        user.htmlURL = self.htmlURL
    }
}
