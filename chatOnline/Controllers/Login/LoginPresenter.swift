//
//  PresenterLogin.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation

class LoginPresenter{
    func userLogin(email: String, password: String, success: SuccessResponseUser?, failure: FailureResponseType?) {
        LoginService().loginChat(email: email, password: password, success: { (result) in
            success?(result)
        }) { (error) in
            failure?(error)
        }
    }
}
