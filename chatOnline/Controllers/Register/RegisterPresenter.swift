//
//  RegisterPresenter.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
public typealias SuccessResponseUser = (_ response: User) -> Void
public typealias FailureResponseType = (_ error: NSError?) -> Void
class RegisterPresenter {
    func registerUser(email: String, password: String, name: String, lastName: String, contactNumber: String, success: SuccessResponseUser?, failure: FailureResponseType?){
        UserService().setUser(email: email, password: password, name: name, lastName: lastName, contactNumber: contactNumber, success: { (user) in
            success?(user)
        }) { (error) in
            failure?(error)
        }
    }
}
