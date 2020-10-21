//
//  DefaultCell.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 10/19/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit

class DefaultCell: UITableViewCell {
    
    //outlet
    @IBOutlet weak var nameTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
