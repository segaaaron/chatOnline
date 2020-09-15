//
//  User.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
public class User: Entity {
    var email: String?
    var name: String?
    var lastName: String?
    var contactNumber: String?
    var userId: String?
    
    init(){}
    
    init(email: String?, name: String, lastName: String, contactNumber: String, userId: String) {
        self.email = email
        self.name = name
        self.lastName = lastName
        self.contactNumber = contactNumber
        self.userId = userId
    }
}
