//
//  AlertService.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
class AlertService {
    
    func alert(message: String, buttonlabel: String, img : String) -> AlertViewController {
        
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        alertVC.butttonName = buttonlabel
        alertVC.imageName = img
        alertVC.msg = message
        
        return alertVC
    }
}
