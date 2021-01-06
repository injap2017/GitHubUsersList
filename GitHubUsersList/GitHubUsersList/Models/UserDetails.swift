//
//  UserDetails.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import ObjectMapper

class UserDetails: User {
    var name: String = ""
    var company: String = ""
    var blog: String = ""
    var followers: Int = 0
    var following: Int = 0
    var notes: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map["name"]
        self.company <- map["company"]
        self.blog <- map["blog"]
        self.followers <- map["followers"]
        self.following <- map["following"]
    }
    
    func copyTo(_ user: UserDetails) {
        super.copyTo(user)
        
        user.name = self.name
        user.company = self.company
        user.blog = self.blog
        user.followers = self.followers
        user.following = self.following
        user.notes = self.notes
    }
}
