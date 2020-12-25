//
//  UserDetailsViewController.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import UIKit
import SDWebImage

class UserDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    // MARK: - Properties
    var user: UserDetails!
}

// MARK: - Lifecycle
extension UserDetailsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
}

// MARK: - Functions
extension UserDetailsViewController {
    
    class func instance(user: UserDetails) -> UserDetailsViewController {
        let storyboard = UIStoryboard.init(name: "UserDetails", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "userDetails") as! UserDetailsViewController
        viewController.user = user
        return viewController
    }
    
    class func syncData(user: UserDetails, completion: @escaping (UserDetailsViewController?, Error?) -> Void) {
        
        AppSync.Users.getUser(of: user.username) { (user, error) in
            if let error = error {
                print(error)
                
                completion(nil, error)
                return
            }
            
            let viewController = UserDetailsViewController.instance(user: user!)
            completion(viewController, nil)
        }
    }
    
    func initView() {
        // title
        self.title = user.username
        
        self.avatarImageView.sd_setImage(with: URL(string: user.avatar))
        self.followersLabel.text = "followers: \(user.followers)"
        self.followingLabel.text = "following: \(user.following)"
        self.nameLabel.text = user.name
        self.companyLabel.text = user.company
        self.blogLabel.text = user.blog
        self.notesTextView.text = user.notes
    }
}

// MARK: - Actions
extension UserDetailsViewController {
    
    @IBAction func saveNotes(_ sender: UIButton) {
        let notes = self.notesTextView.text!
        self.updateUser(with: notes)
    }
}

// MARK: - Functions
extension UserDetailsViewController {
    
    func updateUser(with notes: String) {
        // local updates
        self.user.notes = notes
        
        // store updates
        Store.Users.updateUser(user)
        
        // notify updated
        let userInfo = ["id": self.user.id,
                        "notes": notes] as [String : Any]
        NotificationCenter.default.post(name: AppData.Notifications.UserUpdated, object: self, userInfo: userInfo)
    }
}
