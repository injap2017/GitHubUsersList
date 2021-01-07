//
//  UsersStore.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import UIKit
import CoreData

class UsersStore {
    
    func addUser(_ user: UserDetails) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserDetailsCore", in: context)!
        
        do {
            let u = NSManagedObject(entity: entity, insertInto: context) as! UserDetailsCore
            u.setValues(user)
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func getUser(of username: String) -> UserDetails? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDetailsCore")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "login == %@", username)
            let results = try context.fetch(fetchRequest) as! [UserDetailsCore]
            if let u = results.first {
                let pureObject = UserDetails()
                u.copyTo(pureObject)
                
                return pureObject
            }
            return nil
        }
        catch let error {
            print(error)
            return nil
        }
    }
    
    func updateUser(_ user: UserDetails, update: Bool = true) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserDetailsCore", in: context)!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDetailsCore")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "login == %@", user.login)
            let results = try context.fetch(fetchRequest) as! [UserDetailsCore]
            if let u = results.first {
                u.setValues(user)
                try context.save()
            } else {
                if update == true {
                    let u = NSManagedObject(entity: entity, insertInto: context) as! UserDetailsCore
                    u.setValues(user)
                    try context.save()
                }
            }
        }
        catch let error {
            print(error)
        }
    }
    
    func updateUserIgnoreNotes(_ user: UserDetails, update: Bool = true) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserDetailsCore", in: context)!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDetailsCore")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "login == %@", user.login)
            let results = try context.fetch(fetchRequest) as! [UserDetailsCore]
            if let u = results.first {
                u.setValuesIgnoreNotes(user)
                try context.save()
            } else {
                if update == true {
                    let u = NSManagedObject(entity: entity, insertInto: context) as! UserDetailsCore
                    u.setValues(user)
                    try context.save()
                }
            }
        }
        catch let error {
            print(error)
        }
    }
    
    func getUsers(since at: Int, per_page: Int) -> [UserDetails] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDetailsCore")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "id > \(at)")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            fetchRequest.fetchLimit = per_page
            
            let objects = try context.fetch(fetchRequest) as! [UserDetailsCore]
            
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
    
    func updateUsersIgnoreDetails(_ users: [UserDetails], update: Bool = true) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserDetailsCore", in: context)!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDetailsCore")
        
        do {
            for user in users {
                fetchRequest.predicate = NSPredicate(format: "login == %@", user.login)
                let results = try context.fetch(fetchRequest) as! [UserDetailsCore]
                if let u = results.first {
                    u.setValuesIgnoreDetails(user)
                    try context.save()
                } else {
                    if update == true {
                        let u = NSManagedObject(entity: entity, insertInto: context) as! UserDetailsCore
                        u.setValues(user)
                        try context.save()
                    }
                }
            }
        }
        catch let error {
            print(error)
        }
    }
}

// MARK: - Search
extension UsersStore {
    
    func searchUsers(with text: String) -> [UserDetails] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserDetailsCore")
        
        do {
            fetchRequest.predicate = NSPredicate(format: "login CONTAINS[c] '\(text)' OR notes CONTAINS[c] '\(text)'")
            let objects = try context.fetch(fetchRequest) as! [UserDetailsCore]
            
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
