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
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var contactNameTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retryPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let alert = AlertService()
    var loading: Loading!
    let dispatchGroup =  DispatchGroup()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.lastnameTextfield.delegate = self
            self.contactNameTextfield.delegate = self
            self.nameTextfield.delegate = self
            self.retryPasswordTextField.delegate = self
            self.emailTextField.delegate = self
            self.passwordTextField.delegate = self
            self.configOutlets()
            self.loading = Loading()
        }
        
        @IBAction func LoginAction(_ sender: Any) {
            self.loading.showLoading(onView: self.view)
            let email = self.emailTextField.text!
            let password = self.passwordTextField.text!
            let name = self.nameTextfield.text!
            let lastName = self.lastnameTextfield.text!
            let contactNumber = self.contactNameTextfield.text!
            RegisterPresenter().registerUser(email: email, password: password, name: name, lastName: lastName, contactNumber: contactNumber, success: { (user) in
                if (user.userId != nil) {
                    let alertVC = self.alert.alert(message: SUCCESS_REGISTER, buttonlabel: btnContinue, img: success_icon)
                    self.present(alertVC, animated: true, completion: nil)
                    
                    self.navigationController?.popViewController(animated: true)
                    self.loading.removeLoading()
                }
            }) { (error) in
                let alertVC = self.alert.alert(message:"\(error!.userInfo["msg"]!)", buttonlabel: btnContinue, img: error_icon)
                self.present(alertVC, animated: true, completion: nil)
                self.loading.removeLoading()
            }
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
        
        func configOutlets() {
            //config contactTextfield
            contactNameTextfield.translatesAutoresizingMaskIntoConstraints = false
            contactNameTextfield.autocapitalizationType = .none
            contactNameTextfield.autocorrectionType = .no
            contactNameTextfield.returnKeyType = .done
            contactNameTextfield.layer.cornerRadius = 12
            contactNameTextfield.layer.borderWidth = 1
            contactNameTextfield.layer.borderColor = UIColor.lightGray.cgColor
            contactNameTextfield.placeholder = "Contact Number"
            contactNameTextfield.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
            contactNameTextfield.leftViewMode = .always
            contactNameTextfield.backgroundColor = .secondarySystemBackground

            // config LastNameTextfield
            lastnameTextfield.translatesAutoresizingMaskIntoConstraints = false
            lastnameTextfield.autocapitalizationType = .none
            lastnameTextfield.autocorrectionType = .no
            lastnameTextfield.returnKeyType = .done
            lastnameTextfield.layer.cornerRadius = 12
            lastnameTextfield.layer.borderWidth = 1
            lastnameTextfield.layer.borderColor = UIColor.lightGray.cgColor
            lastnameTextfield.placeholder = "Last Name"
            lastnameTextfield.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
            lastnameTextfield.leftViewMode = .always
            lastnameTextfield.backgroundColor = .secondarySystemBackground

            // config retryPasswordTextfield
            retryPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
            retryPasswordTextField.autocapitalizationType = .none
            retryPasswordTextField.autocorrectionType = .no
            retryPasswordTextField.returnKeyType = .done
            retryPasswordTextField.layer.cornerRadius = 12
            retryPasswordTextField.layer.borderWidth = 1
            retryPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
            retryPasswordTextField.placeholder = "Retry-Password"
            retryPasswordTextField.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
            retryPasswordTextField.leftViewMode = .always
            retryPasswordTextField.backgroundColor = .secondarySystemBackground
            retryPasswordTextField.isSecureTextEntry = true
            //config nameTextfield
            nameTextfield.translatesAutoresizingMaskIntoConstraints = false
            nameTextfield.autocapitalizationType = .none
            nameTextfield.autocorrectionType = .no
            nameTextfield.returnKeyType = .continue
            nameTextfield.layer.cornerRadius = 12
            nameTextfield.layer.borderWidth = 1
            nameTextfield.layer.borderColor = UIColor.lightGray.cgColor
            nameTextfield.placeholder = "Name"
            nameTextfield.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
            nameTextfield.leftViewMode = .always
            nameTextfield.backgroundColor = .secondarySystemBackground
            // config emailsTextfield
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            emailTextField.autocapitalizationType = .none
            emailTextField.autocorrectionType = .no
            emailTextField.returnKeyType = .continue
            emailTextField.layer.cornerRadius = 12
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            emailTextField.placeholder = "Email Address"
            emailTextField.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
            emailTextField.leftViewMode = .always
            emailTextField.backgroundColor = .secondarySystemBackground
            // config passwordTextfield
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.autocapitalizationType = .none
            passwordTextField.autocorrectionType = .no
            passwordTextField.returnKeyType = .done
            passwordTextField.layer.cornerRadius = 12
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField.placeholder = "Password"
            passwordTextField.leftView = UIView(frame: CGRect(x: 40, y: 0, width: 5, height: 20))
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
        
    }
