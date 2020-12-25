//
//  UsersViewController.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import UIKit
import SVProgressHUD
import PullToRefreshKit
import Alamofire

class UsersViewController: UITableViewController {

    // MARK: - Properties
    var since: Int = 0
    var per_page: Int = 20
    var users: [UserDetails] = []
    
    deinit {
        removeNotificationListeners()
    }
}

// MARK: - Lifecycle
extension UsersViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.listenNotifications()
        
        Reachability.shared.addObserver(self)
    }
}

// MARK: - Reachability
extension UsersViewController: ReachabilityObserver {
    func reachabilityListener(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .reachable(.ethernetOrWiFi), .reachable(.cellular):
            // if data is empty, then try to connect and fetch datas
            if self.users.count == 0 {
                self.infiniteScrollingAction()
            }
            break
        case .unknown, .notReachable:
            break
        }
    }
}

// MARK: - Functions
extension UsersViewController {
    
    func initView() {
        // title
        self.title = "GitHub Users List"
        
        // register tableview cells
        self.tableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.identifier)
        
        // search bar
        let searchResultsController = UsersSearchResultsController()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.searchBar.placeholder = "Search Users"
        navigationItem.searchController = searchController
        
        // infinite scroll
        self.tableView.configRefreshFooter(container: self, action: infiniteScrollingAction)
    }
/*
    func initModel() {
        let localUsers = Store.Users.getUsers(since: since, per_page: per_page)
        if localUsers.count == 0 {
            return
        }
        
        self.users.append(contentsOf: localUsers)
    }*/
    
    func listenNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(userUpdatedNotificationHandler), name: AppData.Notifications.UserUpdated, object: nil)
    }
    
    func removeNotificationListeners() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getUsers(since at: Int, per_page: Int) {
        AppSync.Users.getUsers(since: since, per_page: per_page) { (users, error) in
            guard let users = users, users.count > 0 else {
                return
            }
            
            // update since
            self.since = users.last!.id
            
            // append data, add more rows in table
            let start = self.users.count
            var indexPaths: [IndexPath] = []
            for i in start..<(start + users.count) {
                let indexPath = IndexPath(row: i, section: 0)
                indexPaths.append(indexPath)
            }
            
            self.users.append(contentsOf: users)
            
            self.tableView.performBatchUpdates {
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            } completion: { (finished) in
                self.tableView.switchRefreshFooter(to: .normal)
            }
        }
    }
}

// MARK: - Actions
extension UsersViewController {
    
    @objc func infiniteScrollingAction() {
        self.getUsers(since: since, per_page: per_page)
    }
    
    func viewDetails(_ user: UserDetails) {
        
        SVProgressHUD.show(withStatus: "Loading Details...")
        
        UserDetailsViewController.syncData(user: user) { (viewController, error) in
            if let error = error {
                print(error)
                
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                return
            }
            
            self.navigationController?.pushViewController(viewController!, animated: true)
            SVProgressHUD.dismiss()
        }
    }
    
    @objc func userUpdatedNotificationHandler(_ sender: NSNotification) {
        let userInfo = sender.userInfo as! [String : Any]
        let id = userInfo["id"] as! Int
        let notes = userInfo["notes"] as! String

        let row = self.users.firstIndex { (user) -> Bool in
            return user.id == id
        }
        if let row = row {
            let user = self.users[row]
            user.notes = notes
            
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableView
extension UsersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as! UserCell
        
        let user = self.users[indexPath.row]
        cell.user = user
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        self.viewDetails(user)
    }
}
