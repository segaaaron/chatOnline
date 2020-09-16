//
//  ProfilePresenter.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation

public typealias SuccessResponseProfile = (_ response: Profile) -> Void

class ProfilePresenter {
    func updateProfile(name: String, lastName: String, contactNumber: String, success: SuccessResponseProfile, failure: FailureResponseType ) {
        
    }
    
    func getProfile(userID: String, success: SuccessResponseProfile?, failure: FailureResponseType? ) {
        ProfileService().getProfile(userId: userID, success: { (profile) in
            success?(profile)
        }) { (error) in
            failure?(error)
        }
    }
}
