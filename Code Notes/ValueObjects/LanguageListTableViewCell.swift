//
//  LanguageListTableViewCell.swift
//  Code Notes
//
//  Created by Peter Witham on 2/7/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class LanguageListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLanguageName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
