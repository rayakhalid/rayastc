//
//  reposTableViewCell.swift
//  stc challenge
//
//  Created by Raya Khalid on 15/11/2021.
//
import Foundation
import UIKit
import TextFieldEffects

class reposTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reponame: UITextField!
    @IBOutlet weak var repodesc: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
