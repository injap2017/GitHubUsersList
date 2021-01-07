//
//  UserDetails.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation

struct UserDetails: Codable {
    var id: Int = -1
    var login: String = ""
    var avatar_url: String = ""
    var url: String = ""
    var html_url: String = ""
    var name: String = ""
    var company: String = ""
    var blog: String = ""
    var followers: Int = 0
    var following: Int = 0
    var notes: String = ""
}
