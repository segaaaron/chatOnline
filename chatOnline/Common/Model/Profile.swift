//
//  Profile.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
import UIKit

public class Profile: Entity {
    var name: String?
    var lastName: String?
    var contactNumber: String?
    var email: String?
    var userId: String?
    var photoImage: UIImage?
    
    init(){}
    
    init(name: String, lastName: String, contactNumber: String, email: String, userId: String) {
        self.name = name
        self.lastName = lastName
        self.contactNumber = contactNumber
        self.email = email
        self.userId = userId
    }
}
