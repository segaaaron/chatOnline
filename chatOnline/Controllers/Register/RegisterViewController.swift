//
//  RegisterViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
        // outlets
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!
        @IBOutlet weak var loginButton: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.configOutlets()
        }
        
        func configOutlets() {
            // config emailsTextfield
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            emailTextField.autocapitalizationType = .none
            emailTextField.autocorrectionType = .no
            emailTextField.returnKeyType = .continue
            emailTextField.placeholder = "Email Address..."
            emailTextField.leftViewMode = .always
            emailTextField.backgroundColor = .secondarySystemBackground
            // config passwordTextfield
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.autocapitalizationType = .none
            passwordTextField.autocorrectionType = .no
            passwordTextField.returnKeyType = .done
            passwordTextField.placeholder = "Password..."
            passwordTextField.leftViewMode = .always
            passwordTextField.backgroundColor = .secondarySystemBackground
            passwordTextField.isSecureTextEntry = true
            // button login
            loginButton.setTitle("Log In", for: .normal)
            loginButton.backgroundColor = .link
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.layer.cornerRadius = 12
            loginButton.layer.masksToBounds = true
            loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        
        @IBAction func LoginAction(_ sender: Any) {
        }
        
    }

    extension RegisterViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
    }