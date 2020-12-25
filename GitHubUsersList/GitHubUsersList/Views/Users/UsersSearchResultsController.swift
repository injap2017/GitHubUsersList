//
//  UsersSearchResultsController.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/25/20.
//

import UIKit
import SVProgressHUD

class UsersSearchResultsController: UITableViewController {
    
    // MARK: - Properties
    var searchedUsers: [UserDetails] = []
    
    deinit {
        removeNotificationListeners()
    }
}

// MARK: - Lifecycle
extension UsersSearchResultsController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.listenNotifications()
    }
}

// MARK: - Functions
extension UsersSearchResultsController {
    
    func initView() {
        
        // register tableview cell
        self.tableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.identifier)
    }
    
    func listenNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(userUpdatedNotificationHandler), name: AppData.Notifications.UserUpdated, object: nil)
    }
    
    func removeNotificationListeners() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Actions
extension UsersSearchResultsController {
    
    func viewDetails(_ user: UserDetails) {
        
        SVProgressHUD.show(withStatus: "Loading Details...")
        
        UserDetailsViewController.syncData(user: user) { (viewController, error) in
            if let error = error {
                print(error)
                
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                return
            }
            
            self.presentingViewController?.navigationController?.pushViewController(viewController!, animated: true)
            SVProgressHUD.dismiss()
        }
    }
    
    @objc func userUpdatedNotificationHandler(_ sender: NSNotification) {
        let userInfo = sender.userInfo as! [String : Any]
        let id = userInfo["id"] as! Int
        let notes = userInfo["notes"] as! String

        let row = self.searchedUsers.firstIndex { (user) -> Bool in
            return user.id == id
        }
        if let row = row {
            let user = self.searchedUsers[row]
            user.notes = notes
            
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableView
extension UsersSearchResultsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as! UserCell
        
        let user = self.searchedUsers[indexPath.row]
        cell.user = user
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.searchedUsers[indexPath.row]
        self.viewDetails(user)
    }
}

// MARK: - UISearchController
extension UsersSearchResultsController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.searchUsers(with: text)
        self.tableView.reloadData()
    }
    
    func searchUsers(with text: String) {
        let users = Store.Users.searchUsers(with: text)
        self.searchedUsers = users
    }
}
