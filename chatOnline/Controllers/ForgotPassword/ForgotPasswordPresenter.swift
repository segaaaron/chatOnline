//
//  ForgotPasswordPresenter.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
class ForgotPasswordPresenter {
    func forgotPassword (email: String, failure: FailureResponseType?) {
        ForgotPasswordService().forgotPassword(email: email) { (error) in
            failure?(error)
        }
    }
}
