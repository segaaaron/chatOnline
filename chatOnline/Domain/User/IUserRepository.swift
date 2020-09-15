//
//  UserRepository.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
class IUserRepository: IUser{
    func saveUser(email: String, password: String, name: String, lastName: String, contactNumber: String, success: SuccessResponseUser?, failure: FailureResponseType?) {
        UserRepository().saveUser(email: email, password: password, name: name, lastName: lastName, contactNumber: contactNumber, success: { (user) in
            success?(user)
        }) { (error) in
            failure?(error)
        }
    }
}
