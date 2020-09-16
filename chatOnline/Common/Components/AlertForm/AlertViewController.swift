//
//  AlertViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

       //outlets
        @IBOutlet weak var iconAlertImage: UIImageView!
        @IBOutlet weak var messageLabel: UILabel!
        @IBOutlet weak var continueBtn: UIButton!
        @IBOutlet weak var mainBodyView: UIView!
        
        var msg: String?
        var butttonName: String?
        var imageName: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupOutlets()
            customMainBody()
        }
        
        func customMainBody() {
            mainBodyView.layer.cornerRadius = 15
            mainBodyView.clipsToBounds = true
        }
        
        func setupOutlets() {
            continueBtn.setTitle(butttonName, for: .normal)
            continueBtn.layer.cornerRadius = 15
            iconAlertImage.image = UIImage(named: imageName!)
    //        iconAlertImage.image = UIImage(systemName: self.icon!)
            messageLabel.text = msg
        }
        
        @IBAction func DismissButton(_ sender: UIButton) {
            print("entro")
            dismiss(animated: true, completion: nil)
        }

    }
