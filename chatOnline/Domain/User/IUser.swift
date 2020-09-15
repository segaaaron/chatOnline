//
//  IUser.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
protocol IUser {
    func saveUser(email: String, password: String, name: String, lastName: String, contactNumber: String, success: SuccessResponseUser?, failure: FailureResponseType?)
}
