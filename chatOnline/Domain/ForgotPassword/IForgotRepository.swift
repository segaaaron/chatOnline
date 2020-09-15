//
//  IForgotRepository.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
class IForgotRepository: IForgot {
    func forgotPassword(email: String, failure: FailureResponseType?) {
        ForgotRepository().sendForgotPassword(email: email) { (error) in
            failure?(error)
        }
    }
}
