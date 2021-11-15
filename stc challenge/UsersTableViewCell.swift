//
//  UsersTableViewCell.swift
//  stc challenge
//
//  Created by Raya Khalid on 15/11/2021.
//

import Foundation
import UIKit
import TextFieldEffects

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var reponumber: UITextField!
    @IBOutlet weak var usernameGithub: UITextField!
    @IBOutlet weak var followersnumber: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
