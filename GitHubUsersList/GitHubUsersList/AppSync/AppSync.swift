//
//  AppSync.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation

class AppSync {
    static var Users = UsersSync()
    
    static let unavailable = NSError.init(domain: "In App Domain", code: 401, userInfo: [NSLocalizedDescriptionKey : "Unavailable Network and Data"]) as Error
}
