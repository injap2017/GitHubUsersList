//
//  UserCell.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 12/23/20.
//

import UIKit
import SDWebImage

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
                self.avatarImageView.sd_setImage(with: URL(string: user.avatar))
                self.usernameLabel.text = user.username
                self.detailsLabel.text = user.htmlURL
                self.noteButton.isHidden = user.notes.isEmpty
            }
        }
    }
    
    static let identifier = "UserCell"
    static let nib = UINib.init(nibName: "UserCell", bundle: nil)
}
