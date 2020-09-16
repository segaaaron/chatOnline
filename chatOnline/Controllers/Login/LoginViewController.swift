//
//  LoginViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    // outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let alert = AlertService()
    var loading: Loading!
    let dispatchGroup =  DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configOutlets()
        self.loading = Loading()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            userAlreadyLogged()
        }

    func userAlreadyLogged() {
        let isLoggin = (Auth.auth().currentUser != nil) ? true : false
        if(isLoggin) {
            let tabBarVC = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "HomeTabVC")
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        self.loading.showLoading(onView: self.view)
        let email = emailTextField.text!
        let password = passwordTextField.text!
        LoginPresenter().userLogin(email: email, password: password, success: { (result) in
            print(result)
            if(result.userId != nil) {
                let alertVC = self.alert.alert(message: SUCESS_LOGIN, buttonlabel: btnContinue, img: success_icon)
                self.present(alertVC, animated: true, completion: nil)
                let tabBarVC = UIStoryboard(name: "Home", bundle: .main).instantiateViewController(withIdentifier: "HomeTabVC")
                self.navigationController?.pushViewController(tabBarVC, animated: true)
                self.loading.removeLoading()
            } else {
                self.loading.removeLoading()
            }
        }) { (error) in
            
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
    
    func configOutlets() {
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
