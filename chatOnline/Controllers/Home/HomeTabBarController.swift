//
//  HomeTabBarController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
