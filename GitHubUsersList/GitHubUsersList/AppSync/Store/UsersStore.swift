//
//  UsersStore.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import Foundation
import RealmSwift

class UsersStore {
    
    func addUser(_ user: UserDetails) {
        let u = UserDetails()
        user.copyTo(u)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(u)
            }
        } catch let error {
            print(error)
        }
    }
    
    func getUser(of username: String) -> UserDetails? {
        do {
            let realm = try Realm()
            let object = realm.object(ofType: UserDetails.self, forPrimaryKey:username)
            if let object = object {
                let pureObject = UserDetails()
                object.copyTo(pureObject)
                
                return pureObject
            }
            return nil
        }
        catch let error {
            print(error)
            return nil
        }
    }
    
    func updateUser(_ user: UserDetails) {
        let u = UserDetails()
        user.copyTo(u)
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(u, update: .all)
            }
        }
        catch let error {
            print(error)
        }
    }
    
    func updateUserIgnoreNotes(_ user: UserDetails) {
        let u = UserDetails()
        user.copyTo(u)
        
        do {
            let realm = try Realm()
            
            let object = realm.object(ofType: UserDetails.self, forPrimaryKey: u.username)
            if let object = object {
                u.notes = object.notes
            }
            
            try realm.write {
                realm.add(u, update: .all)
            }
        }
        catch let error {
            print(error)
        }
    }
    
    func updateUserIgnoreDetails(_ user: UserDetails) {
        let u = UserDetails()
        user.copyTo(u)
        
        do {
            let realm = try Realm()
            
            let object = realm.object(ofType: UserDetails.self, forPrimaryKey: u.username)
            if let object = object {
                u.notes = object.notes
                
                u.name = object.name
                u.company = object.company
                u.blog = object.blog
                u.followers = object.followers
                u.following = object.following
            }
            
            try realm.write {
                realm.add(u, update: .all)
            }
        }
        catch let error {
            print(error)
        }
    }
    
    func addUsers(_ users: [UserDetails]) {
        var us: [UserDetails] = []
        for user in users {
            let u = UserDetails()
            user.copyTo(u)
            
            us.append(u)
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                for u in us {
                    realm.add(u)
                }
            }
        } catch let error {
            print(error)
        }
    }

    func getUsers(since at: Int, per_page: Int) -> [UserDetails] {
        do {
            let realm = try Realm()
            let objects = realm.objects(UserDetails.self).filter("id > \(at)").sorted(byKeyPath: "id", ascending: true)
            
            var pureObjects: [UserDetails] = []
            for (i, object) in objects.enumerated() {
                if i >= per_page {break;}
                let pureObject = UserDetails()
                object.copyTo(pureObject)
                
                pureObjects.append(pureObject)
            }
            
            return pureObjects
        }
        catch let error as NSError {
            print(error)
            return []
        }
    }
    
    func updateUsers(_ users: [UserDetails]) {
        var us: [UserDetails] = []
        for user in users {
            let u = UserDetails()
            user.copyTo(u)
            
            us.append(u)
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                for u in us {
                    realm.add(u, update: .all)
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateUsersIgnoreNotes(_ users: [UserDetails]) {
        var us: [UserDetails] = []
        for user in users {
            let u = UserDetails()
            user.copyTo(u)
            
            us.append(u)
        }
        
        do {
            let realm = try Realm()
            
            for u in us {
                let object = realm.object(ofType: UserDetails.self, forPrimaryKey: u.username)
                if let object = object {
                    u.notes = object.notes
                }
            }
            
            try realm.write {
                for u in us {
                    realm.add(u, update: .all)
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateUsersIgnoreDetails(_ users: [UserDetails]) {
        var us: [UserDetails] = []
        for user in users {
            let u = UserDetails()
            user.copyTo(u)
            
            us.append(u)
        }
        
        do {
            let realm = try Realm()
            
            for u in us {
                let object = realm.object(ofType: UserDetails.self, forPrimaryKey: u.username)
                if let object = object {
                    u.notes = object.notes
                    
                    u.name = object.name
                    u.company = object.company
                    u.blog = object.blog
                    u.followers = object.followers
                    u.following = object.following
                }
            }
            
            try realm.write {
                for u in us {
                    realm.add(u, update: .all)
                }
            }
        } catch let error {
            print(error)
        }
    }
}

// MARK: - Search
extension UsersStore {
    
    func searchUsers(with text: String) -> [UserDetails] {
        do {
            let realm = try Realm()
            let objects = realm.objects(UserDetails.self).filter("username CONTAINS[c] '\(text)' OR notes CONTAINS[c] '\(text)'")
            
            var pureObjects: [UserDetails] = []
            for object in objects {
                let pureObject = UserDetails()
                object.copyTo(pureObject)
                
                pureObjects.append(pureObject)
            }
            
            return pureObjects
        } catch let error {
            print(error)
            return []
        }
    }
}
