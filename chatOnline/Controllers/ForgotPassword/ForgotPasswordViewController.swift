//
//  ForgotPasswordViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ForgotPasswordViewController: UIViewController {
// outlets

    @IBOutlet weak var resendEmailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var loginButton: UIButton!
    
    var _statusEmail = false
    var statusEmail : Bool {
        get {
            return _statusEmail
        }
        set {
            _statusEmail = newValue
        }
    }
    
    let alert = AlertService()
//    var loading: Loading!
    let dispatchGroup =  DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        self.loading = Loading()
//        self.loading.showLoading(onView: self.view)
//        emailTextField.delegate = self
//        dispatchGroup.notify(queue: .main) {
//            self.loading.removeLoading()
//        }
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        let email = resendEmailTextField.text!
        
        dispatchGroup.enter()
        ForgotPasswordPresenter().forgotPassword(email: email) { (error) in
            if(error == nil) {
                let alertVC = self.alert.alert(message: SUCCESS_EMAIL_RESET, buttonlabel: btnContinue, img: success_icon)
                self.present(alertVC, animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                self.dispatchGroup.leave()
            } else {
                let alertVC = self.alert.alert(message:"\(error!.userInfo["msg"]!)", buttonlabel: btnContinue, img: error_icon)
                self.present(alertVC, animated: true, completion: nil)
//                self.loading.removeLoading()
            }
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
    
    @objc func validationTextFieldEmail(_ textField: UITextField) {
        if let text = textField.text {
            if let labelError = textField as? SkyFloatingLabelTextFieldWithIcon {
                let isValidMail = validatorEmail(email: text)
                if(!isValidMail) {
                    labelError.errorMessage = "Invalid Field"
                    statusEmail = false
                    if(!statusEmail) {
                        loginButton.isEnabled = false
                        loginButton.backgroundColor = .gray
                    }
                } else {
                    labelError.errorMessage = ""
                    statusEmail = true
                    if(statusEmail) {
                        loginButton.isEnabled = true
                        loginButton.backgroundColor = actionButtonColor
                    }
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
        
         // config emailsTextfield
        self.resendEmailTextField.tintColor = .cyan
        self.resendEmailTextField.selectedTitleColor = .cyan
        self.resendEmailTextField.selectedLineColor = .cyan
        self.resendEmailTextField.titleColor = .cyan
        
        self.resendEmailTextField.errorColor = .red
        self.resendEmailTextField.addTarget(self, action: #selector(validationTextFieldEmail), for: .editingChanged)
        
        self.resendEmailTextField.iconType = .image
        self.resendEmailTextField.iconColor = .gray
        self.resendEmailTextField.selectedIconColor = .white
        self.resendEmailTextField.iconMarginLeft = 10.0

         // button login
         loginButton.setTitle("Send", for: .normal)
         loginButton.setTitleColor(.white, for: .normal)
         loginButton.backgroundColor = UIColor.gray
         loginButton.isEnabled = false
         loginButton.layer.cornerRadius = 20
         loginButton.layer.masksToBounds = true
     }
    
}
