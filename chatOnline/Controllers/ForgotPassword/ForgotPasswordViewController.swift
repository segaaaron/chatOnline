//
//  ForgotPasswordViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
// outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    //segueName
    
    var goRegister = "forgotSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configOutlets()
        emailTextField.delegate = self
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        let email = self.emailTextField.text!
        ForgotPasswordPresenter().forgotPassword(email: email) { (error) in
            print(error!.localizedDescription)
        }
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField", textField)
        self.view.endEditing(true)
        return false
    }
    
    func hidekeyboardWhentappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configOutlets() {
         // config emailsTextfield
         emailTextField.translatesAutoresizingMaskIntoConstraints = false
         emailTextField.autocapitalizationType = .none
         emailTextField.autocorrectionType = .no
         emailTextField.returnKeyType = .continue
         emailTextField.layer.cornerRadius = 12
         emailTextField.layer.borderWidth = 1
         emailTextField.layer.borderColor = UIColor.lightGray.cgColor
         emailTextField.placeholder = "Email Address..."
         emailTextField.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
         emailTextField.leftViewMode = .always
         emailTextField.backgroundColor = .secondarySystemBackground
         // button login
         loginButton.setTitle("Log In", for: .normal)
         loginButton.backgroundColor = .link
         loginButton.setTitleColor(.white, for: .normal)
         loginButton.layer.cornerRadius = 12
         loginButton.layer.masksToBounds = true
         loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
     }
    
}
