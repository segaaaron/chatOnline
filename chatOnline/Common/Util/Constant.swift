//
//  ErrorMessage.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
    let blue = CGFloat(rgbValue & 0xFF)/255.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}

// Error or Success Mesage
let SUCESS_LOGIN = "Successful Login"
let SUCCESS_EMAIL_RESET = "We send you by email the password reset"
let SUCCESS_REGISTER = "Successful registration"
let ERROR_LOGIN = "Email not registered"
let ERROR_LOGOUT = "Failed to log out"
let WRONG_SIMILARPASSWORD = "Passwords are not the same"
let ERROR_UNEXPECTED = "Unexpected Error"
let SUCCESS_UPDATE = "Profile Updated"

// Colors
let loginNavigationColor = UIColorFromHex(0x3e5068)
let actionButtonColor = UIColorFromHex(0x7EABC4)
let changeLogoutColor = UIColorFromHex(0xf7505a)
let colorTomato = UIColorFromHex(0xe96656)


// Segue
let goRegisterSegue = "registerSegue"
let goForgotPassword = "forgotSegue"
let goEditSegue = "detailUserSegue"

//Assets icons
let success_icon = "success"
let error_icon = "error"
let warning_icon = "warning"

// button title
let btnContinue = "Continue"

//identifier StoryBoard
let homeTabVC = "HomeTabVC"

// storiboardName
let khome = "Home"
let kmain = "Main"

//Cell identifier
let kcellProfile = "ProfileCell"
let kcustomCell = "CustomProfileCell"

//XIB name
let profileXib = "ProfileImageXib"
