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
    
    // this is the repositry table view cell elemnts
    @IBOutlet weak var descreption: UITextView!
    @IBOutlet weak var reponame: UITextField!
    @IBOutlet weak var licensename: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
