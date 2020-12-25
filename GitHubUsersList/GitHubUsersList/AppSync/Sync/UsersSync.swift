//
//  UsersSync.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation

class UsersSync {
    
    func getUser(of username: String, completion: @escaping(UserDetails?, Error?) -> Void) {
        let localUser = Store.Users.getUser(of: username)
        if let localUser = localUser {
            if Reachability.shared.isReachable {
                APIs.Users.getUser(of: username) { (user, error) in
                    if let error = error {
                        print(error)
                        
                        completion(localUser, nil)
                        return
                    }
                    
                    Store.Users.updateUserIgnoreNotes(user!)
                    completion(Store.Users.getUser(of: username), nil)
                    return
                }
            } else {
                completion(localUser, nil)
                return
            }
        } else {
            if Reachability.shared.isReachable {
                APIs.Users.getUser(of: username) { (user, error) in
                    if let error = error {
                        print(error)
                        
                        completion(nil, error)
                        return
                    }
                    
                    Store.Users.addUser(user!)
                    completion(Store.Users.getUser(of: username), nil)
                    return
                }
            } else {
                completion(nil, AppSync.unavailable)
                return
            }
        }
    }
    
    func getUsers(since at: Int, per_page: Int, completion: @escaping([UserDetails]?, Error?) -> Void) {
        if Reachability.shared.isReachable {
            APIs.Users.getUsers(since: at, per_page: per_page) { (users, error) in
                if let error = error {
                    print(error)
                    
                    completion(Store.Users.getUsers(since: at, per_page: per_page), nil)
                    return
                }
                
/*
                let dispatchGroup = DispatchGroup()
                
                var us: [UserDetails] = []
                for user in users! {
                    dispatchGroup.enter()
                    APIs.Users.getUser(of: user.username) { (user, error) in
                        if let error = error {
                            print(error)
                            
                            dispatchGroup.leave()
                            return
                        }
                        
                        us.append(user!)
                        dispatchGroup.leave()
                        return
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    us.sort { (first, second) -> Bool in
                        first.id < second.id
                    }
                    
                    Store.Users.updateUsersIgnoreNotes(us)
                    completion(Store.Users.getUsers(since: at, per_page: per_page), nil)
                    return
                }*/
                
                Store.Users.updateUsersIgnoreDetails(users!)
                completion(Store.Users.getUsers(since: at, per_page: per_page), nil)
                return
            }
        } else {
            completion(Store.Users.getUsers(since: at, per_page: per_page), nil)
            return
        }
    }
}
