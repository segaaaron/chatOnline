//
//  CustomProfileCell.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 10/19/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit

class CustomProfileCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var photoImage: UIButton!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var changeImage: UIImageView? {
        willSet{
            getImagePath()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        imageProfile.layer.cornerRadius = 50
        imageProfile.layer.masksToBounds = true
    }
    
    func getImagePath() {
        imageProfile.image = changeImage?.image
    }
}
