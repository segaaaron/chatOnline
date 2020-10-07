//
//  EditPresenter.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 10/7/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
class EditPresenter {
    func updateProfile(userId: String, name: String, lastName: String, contactNumber: String, success: SuccessResponseProfile?, failure: FailureResponseType? ) {
        ManageFirebaseApi().updateProfile(userId: userId, name: name, lastName: lastName, contacNumber: contactNumber) { (result) in
            success?(result)
        } failure: { (error) in
            failure?(error)
        }

    }
}
