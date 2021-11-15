//
//  File.swift
//  stc challenge
//
//  Created by Raya Khalid on 14/11/2021.
//


import UIKit
import TextFieldEffects

class File: UITableViewCell {

    @IBOutlet weak var experienceTitle: HoshiTextField!
    
    @IBOutlet weak var experienceShareDate: HoshiTextField!
    
    @IBOutlet weak var experienceWriter: HoshiTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
