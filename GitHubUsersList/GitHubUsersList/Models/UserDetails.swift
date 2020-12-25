//
//  UserDetails.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import RealmSwift
import ObjectMapper

class UserDetails: User {
    @objc dynamic var name: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var blog: String = ""
    @objc dynamic var followers: Int = 0
    @objc dynamic var following: Int = 0
    @objc dynamic var notes: String = ""
    
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
