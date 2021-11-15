//
//  ExperianceTableViewCell.swift
//  stc challenge
//
//  Created by Raya Khalid on 15/11/2021.
//
import UIKit
import TextFieldEffects

class ExperianceTableViewCell: UITableViewCell {
    @IBOutlet weak var experienceTitle: UITextField!
    
    @IBOutlet weak var experienceWriter: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
