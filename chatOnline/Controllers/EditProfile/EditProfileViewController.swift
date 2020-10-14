//
//  EditProfileViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 10/7/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import FirebaseAuth
import SkyFloatingLabelTextField

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var contactNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var sendProfileButton: UIButton!
    
    var _statusName = false
    var statusName : Bool {
        get {
            return _statusName
        }
        set {
            _statusName = newValue
        }
    }
    var _statusLastName = false
    var statusLastName : Bool {
        get {
            return _statusLastName
        }
        set {
            _statusLastName = newValue
        }
    }
    var _statusContact = false
    var statusContact : Bool {
        get {
            return _statusContact
        }
        set {
            _statusContact = newValue
        }
    }
    
    
    
    let alert = AlertService()
    var dataProfile: Profile?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        contactNumberTextField.delegate = self
        hidekeyboardWhentappedAround()
        let dispatch = DispatchQueue.main
        dispatch.async {
            if let profile = self.dataProfile {
                self.nameTextField.text = profile.name
                self.lastNameTextField.text = profile.lastName
                self.contactNumberTextField.text = profile.contactNumber
            }
        }
    }
    
    @IBAction func sendProfileAction(_ sender: Any) {
        let userId = Auth.auth().currentUser!.uid
        let name = nameTextField.text!
        let lastName = lastNameTextField.text!
        let contactNumber = contactNumberTextField.text!
        
        EditPresenter().updateProfile(userId: userId, name: name, lastName: lastName, contactNumber: contactNumber) { (result) in
            if((result.userId) != nil) {
                let alertVC = self.alert.alert(message: SUCCESS_UPDATE, buttonlabel: btnContinue, img: success_icon)
                self.present(alertVC, animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
        } failure: { (error) in
            print(error!.localizedDescription)
        }

    }
    
}

extension EditProfileViewController: UITextFieldDelegate {
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
    
    @objc func validationTextField(_ textField: UITextField) {
        if let text = textField.text {
            if let labelError = textField as? SkyFloatingLabelTextField {
                switch textField.tag {
                case 0:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid Name"
                        statusName = false
                        if(!statusLastName || !statusName || !statusContact) {
                            sendProfileButton.isEnabled = false
                            sendProfileButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        statusName = true
                        if((statusName && statusLastName && statusContact) || (self.nameTextField.text!.count > 3 && self.lastNameTextField.text!.count > 3 && self.contactNumberTextField.text!.count > 3)) {
                            sendProfileButton.isEnabled = true
                            sendProfileButton.backgroundColor = actionButtonColor
                        }
                    }
                case 1:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid Last Name"
                        statusLastName = false
                        if(!statusLastName || !statusName || !statusContact) {
                            sendProfileButton.isEnabled = false
                            sendProfileButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        statusLastName = true
                        if((statusName && statusLastName && statusContact) || (self.nameTextField.text!.count > 3 && self.lastNameTextField.text!.count > 3 && self.contactNumberTextField.text!.count > 3)) {
                            sendProfileButton.isEnabled = true
                            sendProfileButton.backgroundColor = actionButtonColor
                        }
                    }
                case 2:
                    if(text.count < 3) {
                        labelError.errorMessage = "Invalid Contact Number"
                        statusContact = false
                        if(!statusLastName || !statusName || !statusContact) {
                            sendProfileButton.isEnabled = false
                            sendProfileButton.backgroundColor = .gray
                        }
                    } else {
                        labelError.errorMessage = ""
                        statusContact = true
                        if((statusName && statusLastName && statusContact) || (self.nameTextField.text!.count > 3 && self.lastNameTextField.text!.count > 3 && self.contactNumberTextField.text!.count > 3)) {
                            sendProfileButton.isEnabled = true
                            sendProfileButton.backgroundColor = actionButtonColor
                        }
                    }
                default:
                    break
                }
            }
        }
    }
    
    func setup() {
        self.nameTextField.tintColor = .cyan
        self.nameTextField.selectedTitleColor = .cyan
        self.nameTextField.selectedLineColor = .cyan
        self.nameTextField.titleColor = .cyan
        
        self.nameTextField.tag = 0
        self.nameTextField.placeholder = "Name"
        
        self.nameTextField.errorColor = .red
        self.nameTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        
        self.lastNameTextField.tintColor = .cyan
        self.lastNameTextField.selectedTitleColor = .cyan
        self.lastNameTextField.selectedLineColor = .cyan
        self.lastNameTextField.titleColor = .cyan
        
        self.lastNameTextField.tag = 1
        self.lastNameTextField.placeholder = "Last Name"
        
        self.lastNameTextField.errorColor = .red
        self.lastNameTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        self.contactNumberTextField.tintColor = .cyan
        self.contactNumberTextField.selectedTitleColor = .cyan
        self.contactNumberTextField.selectedLineColor = .cyan
        self.contactNumberTextField.titleColor = .cyan
        
        self.contactNumberTextField.tag = 2
        self.contactNumberTextField.placeholder = "Contact Number"
        
        self.contactNumberTextField.errorColor = .red
        self.contactNumberTextField.addTarget(self, action: #selector(validationTextField), for: .editingChanged)
        
        sendProfileButton.layer.cornerRadius = 20
        sendProfileButton.backgroundColor = actionButtonColor
        sendProfileButton.isEnabled = true
        sendProfileButton.layer.masksToBounds = true
        
    }
}
