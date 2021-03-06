//
//  UserCell.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    
    // MARK: - Properties
    public var user: UserDetails? {
        didSet {
            if let user = user {
                self.avatarImageView.load(url: URL(string: user.avatar_url)!, placeholder: UIImage(named: "blank-avatar"))
                self.usernameLabel.text = user.login
                self.detailsLabel.text = user.html_url
                self.noteButton.isHidden = user.notes.isEmpty
            }
        }
    }
    
    static let identifier = "UserCell"
    static let nib = UINib.init(nibName: "UserCell", bundle: nil)
}
