//
//  ProfileService.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
class ProfileService {
    func getProfile(userId: String, success: SuccessResponseProfile?, failure: FailureResponseType?) {
        let repository: IProfile = IProfileRepository()
        repository.getProfile(userId: userId, success: { (profile) in
            success?(profile)
        }) { (error) in
            failure?(error)
        }
    }
}
