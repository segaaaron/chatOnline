//
//  IProfile.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation

protocol IProfile {
    func getProfile(userId: String, success: SuccessResponseProfile?, failure: FailureResponseType?)
}
