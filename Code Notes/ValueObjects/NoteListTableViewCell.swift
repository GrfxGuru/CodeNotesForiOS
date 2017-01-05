//
//  NoteListTableViewCell.swift
//  Code Notes
//
//  Created by Peter Witham on 1/4/17.
//  Copyright © 2017 Peter Witham. All rights reserved.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteName: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteLanguage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
