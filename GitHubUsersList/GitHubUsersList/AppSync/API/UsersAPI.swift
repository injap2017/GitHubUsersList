//
//  UsersAPI.swift
//  UsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation

class UsersAPI: NetworkController {
    
    func getUser(of username: String, completion: @escaping (UserDetails?, Error?) -> Void) {
        let request = try! Router.getUser(username).asURLRequest()
        
        dataTask(with: request) { (result: Result<UserDetails, NetworkControllerError>) in
            switch result {
            case .success(let user):
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getUsers(since at: Int, per_page: Int, completion: @escaping ([UserDetails]?, Error?) -> Void) {
        let request = try! Router.getUsers(at, per_page).asURLRequest()
        
        dataTask(with: request) { (result: Result<[UserDetails], NetworkControllerError>) in
            switch result {
            case .success(let users):
                completion(users, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
