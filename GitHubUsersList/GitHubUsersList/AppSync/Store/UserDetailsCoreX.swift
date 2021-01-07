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
        setValue(user.login, forKeyPath: "login")
        setValue(user.avatar_url, forKeyPath: "avatar_url")
        setValue(user.url, forKeyPath: "url")
        setValue(user.html_url, forKeyPath: "html_url")
        setValue(user.name, forKeyPath: "name")
        setValue(user.company, forKeyPath: "company")
        setValue(user.blog, forKeyPath: "blog")
        setValue(user.followers, forKeyPath: "followers")
        setValue(user.following, forKeyPath: "following")
        setValue(user.notes, forKeyPath: "notes")
    }
    
    func setValuesIgnoreNotes(_ user: UserDetails) {
        setValue(user.id, forKeyPath: "id")
        setValue(user.login, forKeyPath: "login")
        setValue(user.avatar_url, forKeyPath: "avatar_url")
        setValue(user.url, forKeyPath: "url")
        setValue(user.html_url, forKeyPath: "html_url")
        setValue(user.name, forKeyPath: "name")
        setValue(user.company, forKeyPath: "company")
        setValue(user.blog, forKeyPath: "blog")
        setValue(user.followers, forKeyPath: "followers")
        setValue(user.following, forKeyPath: "following")
    }
    
    func setValuesIgnoreDetails(_ user: UserDetails) {
        setValue(user.id, forKeyPath: "id")
        setValue(user.login, forKeyPath: "login")
        setValue(user.avatar_url, forKeyPath: "avatar_url")
        setValue(user.url, forKeyPath: "url")
        setValue(user.html_url, forKeyPath: "html_url")
    }
    
    func copyTo(_ user: UserDetails) {
        user.id = Int(id)
        user.login = login ?? ""
        user.avatar_url = avatar_url ?? ""
        user.url = url ?? ""
        user.html_url = html_url ?? ""
        user.name = name ?? ""
        user.company = company ?? ""
        user.blog = blog ?? ""
        user.followers = Int(followers)
        user.following = Int(following)
        user.notes = notes ?? ""
    }
}
