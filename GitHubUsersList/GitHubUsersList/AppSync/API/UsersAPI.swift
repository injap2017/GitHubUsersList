//
//  UsersAPI.swift
//  UsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class UsersAPI {
    
    func getUser(of username: String, completion: @escaping (UserDetails?, Error?) -> Void) {
        AF.request(Router.getUser(username))
            .validate(statusCode: 200..<300)
            .responseObject { (response: AFDataResponse<UserDetails>) in
                switch response.result {
                case .success(let user):
                    completion(user, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    func getUsers(since at: Int, per_page: Int, completion: @escaping ([UserDetails]?, Error?) -> Void) {
        AF.request(Router.getUsers(at, per_page))
            .validate(statusCode: 200..<300)
            .responseArray { (response: AFDataResponse<[UserDetails]>) in
                switch response.result {
                case .success(let users):
                    completion(users, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
