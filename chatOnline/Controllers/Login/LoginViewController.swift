//
//  LoginViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import FirebaseAuth
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    // outlets

    @IBOutlet weak var emailTextfield: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var loginButton: UIButton!
    
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
    
    let alert = AlertService()
//    var loading: Loading!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loading = Loading()
        self.passwordTextField.delegate = self
        self.emailTextfield.delegate = self
        hidekeyboardWhentappedAround()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationController?.navigationBar.tintColor = UIColor.white
            userAlreadyLogged()
        }

    func userAlreadyLogged() {
        let isLoggin = (Auth.auth().currentUser != nil) ? true : false
        if(isLoggin) {
            let tabBarVC = UIStoryboard(name: khome, bundle: nil).instantiateViewController(withIdentifier: homeTabVC)
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
//        self.loading.showLoading(onView: self.view)
        let email = self.emailTextfield.text!
        let password = self.passwordTextField.text!
        LoginPresenter().userLogin(email: email, password: password, success: { (result) in
            print(result)
            if(result.userId != nil) {
                let alertVC = self.alert.alert(message: SUCESS_LOGIN, buttonlabel: btnContinue, img: success_icon)
                self.present(alertVC, animated: true, completion: nil)
                let tabBarVC = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "HomeTabVC")
                self.navigationController?.pushViewController(tabBarVC, animated: true)
//                self.loading.removeLoading()
            } else {
//                self.loading.removeLoading()
            }
        }) { (error) in
            let alertVC = self.alert.alert(message: "\(error!.userInfo["msg"]!)", buttonlabel: btnContinue, img: error_icon)
            self.present(alertVC, animated: true, completion: nil)
//            self.loading.removeLoading()
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        performSegue(withIdentifier: goRegisterSegue, sender: self)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        performSegue(withIdentifier: goForgotPassword, sender: self)
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
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
    
    @objc func validationTextField(_ textField: UITextField) {
        if let text = textField.text {
            if let labelError = textField as? SkyFloatingLabelTextFieldWithIcon {
                let isValidMail = validatorEmail(email: text)
                switch textField.tag {
                case 0:
                    if(!isValidMail) {
                        labelError.errorMessage = "Invalid Email"
                        textField1 = false
                        if(!textField1 || textField2) {
                            loginButton.isEnabled = false
                            loginButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        textField1 = true
                        if(textField1 && textField2) {
                            loginButton.isEnabled = true
                            loginButton.backgroundColor = actionButtonColor
                        }
                    }
                case 1:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid Password"
                        textField2 = false
                        if(!textField2 || !textField1) {
                            loginButton.isEnabled = false
                            loginButton.backgroundColor = .gray
                        }
                        loginButton.isEnabled = false
                        loginButton.backgroundColor = .gray
                    } else {
                        labelError.errorMessage = ""
                        textField2 = true
                        if(textField1 && textField2) {
                            loginButton.isEnabled = true
                            loginButton.backgroundColor = actionButtonColor
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
    
    func setup() {
        
        self.emailTextfield.tintColor = .cyan
        self.emailTextfield.selectedTitleColor = .cyan
        self.emailTextfield.selectedLineColor = .cyan
        self.emailTextfield.titleColor = .cyan
        
        self.emailTextfield.errorColor = .red
        self.emailTextfield.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.emailTextfield.iconType = .image
        self.emailTextfield.iconColor = .gray
        self.emailTextfield.selectedIconColor = .white
        self.emailTextfield.iconMarginLeft = 10.0
        
        self.passwordTextField.tintColor = .cyan
        self.passwordTextField.selectedTitleColor = .cyan
        self.passwordTextField.selectedLineColor = .cyan
        self.passwordTextField.titleColor = .cyan
        
        self.passwordTextField.errorColor = .red
        self.passwordTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.passwordTextField.iconType = .image
        self.passwordTextField.iconColor = .gray
        self.passwordTextField.selectedIconColor = .white
        self.passwordTextField.iconMarginLeft = 10.0
        
        loginButton.layer.cornerRadius = 20
        loginButton.backgroundColor = UIColor.gray
        loginButton.isEnabled = false
        loginButton.layer.masksToBounds = true
        
        navigationController?.navigationBar.barTintColor = loginNavigationColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}
