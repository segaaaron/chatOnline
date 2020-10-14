//
//  RegisterViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FontAwesome_swift
import JGProgressHUD

class RegisterViewController: UIViewController {
// outlets
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var contactTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var retryPasswordTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var _textField1 = false
    var textField1 : Bool {
        get {
            return _textField1
        }
        set {
            _textField1 = newValue
        }
    }
    var _textField2 = false
    var textField2 : Bool {
        get {
            return _textField2
        }
        set {
            _textField2 = newValue
        }
    }
    var _textField3 = false
    var textField3 : Bool {
        get {
            return _textField3
        }
        set {
            _textField3 = newValue
        }
    }
    var _textField4 = false
    var textField4 : Bool {
        get {
            return _textField4
        }
        set {
            _textField4 = newValue
        }
    }
    var _textField5 = false
    var textField5 : Bool {
        get {
            return _textField5
        }
        set {
            _textField5 = newValue
        }
    }
    
    
    let alert = AlertService()
    private let spinner = JGProgressHUD(style: .dark)
    let dispatchGroup =  DispatchGroup()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTexfield()
            emailTextField.delegate =  self
            passwordTextField.delegate = self
            retryPasswordTextField.delegate = self
            nameTextField.delegate = self
            lastNameTextField.delegate = self
            contactTextField.delegate = self
            hidekeyboardWhentappedAround()
        }
        
        @IBAction func LoginAction(_ sender: Any) {
            spinner.show(in: view)
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let rePassword = retryPasswordTextField.text!
            let name = nameTextField.text!
            let lastName = lastNameTextField.text!
            let contactNumber = contactTextField.text!
            hidekeyboardWhentappedAround()
            if(password == rePassword) {
                RegisterPresenter().registerUser(email: email, password: password, name: name, lastName: lastName, contactNumber: contactNumber, success: { (user) in
                    if (user.userId != nil) {
                        let alertVC = self.alert.alert(message: SUCCESS_REGISTER, buttonlabel: btnContinue, img: success_icon)
                        self.present(alertVC, animated: true, completion: nil)
                
                        self.navigationController?.popViewController(animated: true)
                        self.spinner.dismiss()
                    }
                }) { (error) in
                    let alertVC = self.alert.alert(message:"\(error!.userInfo["msg"]!)", buttonlabel: btnContinue, img: warning_icon)
                    self.present(alertVC, animated: true, completion: nil)
                    self.spinner.dismiss()
                    }
            }else {
                self.spinner.dismiss()
                let alertVC = self.alert.alert(message: WRONG_SIMILARPASSWORD, buttonlabel: btnContinue, img: warning_icon)
                self.present(alertVC, animated: true, completion: nil)
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
    func setupTexfield() {
        self.nameTextField.tintColor = .cyan
        self.nameTextField.selectedTitleColor = .cyan
        self.nameTextField.selectedLineColor = .cyan
        self.nameTextField.titleColor = .cyan
        
        self.nameTextField.tag = 0
        
        self.nameTextField.errorColor = .red
        self.nameTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.nameTextField.iconType = .image
        self.nameTextField.iconColor = .gray
        self.nameTextField.selectedIconColor = .white
        self.nameTextField.iconMarginLeft = 10.0
        
        self.lastNameTextField.tintColor = .cyan
        self.lastNameTextField.selectedTitleColor = .cyan
        self.lastNameTextField.selectedLineColor = .cyan
        self.lastNameTextField.titleColor = .cyan
        
        self.lastNameTextField.tag = 1
        
        self.lastNameTextField.errorColor = .red
        self.lastNameTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.lastNameTextField.iconType = .image
        self.lastNameTextField.iconColor = .gray
        self.lastNameTextField.selectedIconColor = .white
        self.lastNameTextField.iconMarginLeft = 10.0
        
        self.contactTextField.tintColor = .cyan
        self.contactTextField.selectedTitleColor = .cyan
        self.contactTextField.selectedLineColor = .cyan
        self.contactTextField.titleColor = .cyan
        
        self.contactTextField.tag = 2
        
        self.contactTextField.errorColor = .red
        self.contactTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.contactTextField.iconType = .image
        self.contactTextField.iconColor = .gray
        self.contactTextField.selectedIconColor = .white
        self.contactTextField.iconMarginLeft = 10.0
        
        self.emailTextField.tintColor = .cyan
        self.emailTextField.selectedTitleColor = .cyan
        self.emailTextField.selectedLineColor = .cyan
        self.emailTextField.titleColor = .cyan
        
        self.emailTextField.tag = 3
        
        self.emailTextField.errorColor = .red
        self.emailTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.emailTextField.iconType = .image
        self.emailTextField.iconColor = .gray
        self.emailTextField.selectedIconColor = .white
        self.emailTextField.iconMarginLeft = 10.0
        
        self.passwordTextField.tintColor = .cyan
        self.passwordTextField.selectedTitleColor = .cyan
        self.passwordTextField.selectedLineColor = .cyan
        self.passwordTextField.titleColor = .cyan
        
        self.passwordTextField.tag = 4
        
        self.passwordTextField.errorColor = .red
        self.passwordTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.passwordTextField.iconType = .image
        self.passwordTextField.iconColor = .gray
        self.passwordTextField.selectedIconColor = .white
        self.passwordTextField.iconMarginLeft = 10.0
        
        self.retryPasswordTextField.tintColor = .cyan
        self.retryPasswordTextField.selectedTitleColor = .cyan
        self.retryPasswordTextField.selectedLineColor = .cyan
        self.retryPasswordTextField.titleColor = .cyan
        
        self.retryPasswordTextField.tag = 5
        
        self.retryPasswordTextField.errorColor = .red
        self.retryPasswordTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.retryPasswordTextField.iconType = .image
        self.retryPasswordTextField.iconColor = .gray
        self.retryPasswordTextField.selectedIconColor = .white
        self.retryPasswordTextField.iconMarginLeft = 10.0
        
        registerButton.layer.cornerRadius = 20
        registerButton.isEnabled = false
        registerButton.backgroundColor = .gray
        registerButton.layer.masksToBounds = true
    }
    @objc func validationTextField(_ textField: UITextField) {
        if let text = textField.text {
            if let labelError = textField as? SkyFloatingLabelTextFieldWithIcon {
                let isValidMail = validatorEmail(email: text)
                switch textField.tag {
                case 0:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid Name"
                        textField1 = false
                        if(!textField1 || !textField2 || !textField3 || !textField4 || !textField5) {
                            registerButton.isEnabled = false
                            registerButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField1 = true
                        if(textField1 && textField2 && textField3 && textField4 && textField5) {
                            registerButton.isEnabled = true
                            registerButton.backgroundColor = actionButtonColor
                        }
                    }
                case 1:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid LastName"
                        textField2 = false
                        if(!textField1 || !textField2 || !textField3 || !textField4 || !textField5) {
                            registerButton.isEnabled = false
                            registerButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField2 = true
                        if(textField1 && textField2 && textField3 && textField4 && textField5) {
                            registerButton.isEnabled = true
                            registerButton.backgroundColor = actionButtonColor
                        }
                    }
                case 2:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid Email"
                        textField3 = false
                        if(!textField1 || !textField2 || !textField3 || !textField4 || !textField5) {
                            registerButton.isEnabled = false
                            registerButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField3 = true
                        if(textField1 && textField2 && textField3 && textField4 && textField5) {
                            registerButton.isEnabled = true
                            registerButton.backgroundColor = actionButtonColor
                        }
                    }
                case 3:
                    if(!isValidMail) {
                        labelError.errorMessage = "Invalid Contact Number"
                        textField4 = false
                        if(!textField1 || !textField2 || !textField3 || !textField4 || !textField5) {
                            registerButton.isEnabled = false
                            registerButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField4 = true
                        if(textField1 && textField2 && textField3 && textField4 && textField5) {
                            registerButton.isEnabled = true
                            registerButton.backgroundColor = actionButtonColor
                        }
                    }
                case 4:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid password"
                        textField5 = false
                        if(!textField1 || !textField2 || !textField3 || !textField4 || !textField5) {
                            registerButton.isEnabled = false
                            registerButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField5 = true
                        if(textField1 && textField2 && textField3 && textField4 && textField5) {
                            registerButton.isEnabled = true
                            registerButton.backgroundColor = actionButtonColor
                        }
                    }
                case 5:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid re-password"
                        textField1 = false
                        if(!textField1 || !textField2 || !textField3 || !textField4 || !textField5) {
                            registerButton.isEnabled = false
                            registerButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField1 = true
                        if(textField1 && textField2 && textField3 && textField4 && textField5) {
                            registerButton.isEnabled = true
                            registerButton.backgroundColor = actionButtonColor
                        }
                    }
                    
                default:
                    break
                }
            }
        }
    }
    
    func validatorEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailEvaluate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailEvaluate.evaluate(with: email)
    }
        
    }
