//
//  UserDetailsCoreX.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 1/6/21.
//

import Foundation

extension UserDetailsCore {
    
    func setValues(_ user: UserDetails) {
        setValue(user.id, forKeyPath: "id")
        setValue(user.username, forKeyPath: "username")
        setValue(user.avatar, forKeyPath: "avatar")
        setValue(user.url, forKeyPath: "url")
        setValue(user.htmlURL, forKeyPath: "htmlURL")
        setValue(user.name, forKeyPath: "name")
        setValue(user.company, forKeyPath: "company")
        setValue(user.blog, forKeyPath: "blog")
        setValue(user.followers, forKeyPath: "followers")
        setValue(user.following, forKeyPath: "following")
        setValue(user.notes, forKeyPath: "notes")
    }
    
    func setValuesIgnoreNotes(_ user: UserDetails) {
        setValue(user.id, forKeyPath: "id")
        setValue(user.username, forKeyPath: "username")
        setValue(user.avatar, forKeyPath: "avatar")
        setValue(user.url, forKeyPath: "url")
        setValue(user.htmlURL, forKeyPath: "htmlURL")
        setValue(user.name, forKeyPath: "name")
        setValue(user.company, forKeyPath: "company")
        setValue(user.blog, forKeyPath: "blog")
        setValue(user.followers, forKeyPath: "followers")
        setValue(user.following, forKeyPath: "following")
    }
    
    func setValuesIgnoreDetails(_ user: UserDetails) {
        setValue(user.id, forKeyPath: "id")
        setValue(user.username, forKeyPath: "username")
        setValue(user.avatar, forKeyPath: "avatar")
        setValue(user.url, forKeyPath: "url")
        setValue(user.htmlURL, forKeyPath: "htmlURL")
    }
    
    func copyTo(_ user: UserDetails) {
        user.id = Int(id)
        user.username = username ?? ""
        user.avatar = avatar ?? ""
        user.url = url ?? ""
        user.htmlURL = htmlURL ?? ""
        user.name = name ?? ""
        user.company = company ?? ""
        user.blog = blog ?? ""
        user.followers = Int(followers)
        user.following = Int(following)
        user.notes = notes ?? ""
    }
}
