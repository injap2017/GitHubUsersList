//
//  User.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation

class User: Codable {
    var id: Int = -1
    var login: String = ""
    var avatar_url: String = ""
    var url: String = ""
    var html_url: String = ""
}
