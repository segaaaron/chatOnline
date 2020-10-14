//
//  ProfileViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ProfileViewController: UIViewController {
    //outlets
    @IBOutlet weak var mainNameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactNumberTextfield: UITextField!
    @IBOutlet weak var editProfileButton: UIButton!
    
    let alert = AlertService()
    private let spinner = JGProgressHUD(style: .dark)
    let groupDispatch = DispatchGroup()
    
    var profile = Profile()
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileUser()
        setup()
        self.nameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.contactNumberTextfield.delegate = self
        spinner.show(in: view)
        groupDispatch.notify(queue: .main) {
            self.spinner.dismiss()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    
    func getProfileUser() {
        groupDispatch.enter()
        ProfilePresenter().getProfile(userID: Auth.auth().currentUser!.uid, success: { (profile) in
            self.profile = profile
            self.spinner.dismiss()
            self.mainNameLabel.text = profile.name
            self.nameTextField.text = profile.name
            self.emailTextField.text = profile.email
            self.contactNumberTextfield.text = profile.contactNumber
            self.lastNameTextField.text = profile.lastName
            self.groupDispatch.leave()
            
        }) { (error) in
            let alertVC = self.alert.alert(message: "\(error!.userInfo["msg"]!)", buttonlabel: btnContinue, img: warning_icon)
            self.present(alertVC, animated: true, completion: nil)
            self.groupDispatch.leave()
        }
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "",
                                      message: "Are you sure to Logout?",
                                      preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        do {
                                            try FirebaseAuth.Auth.auth().signOut()

                                                let logginVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginVC")
                                                let navController = UINavigationController(rootViewController: logginVC)
                                            
                                                strongSelf.view.window?.rootViewController = navController
                                        }
                                        catch {
                                            let alertVC = self?.alert.alert(message: ERROR_UNEXPECTED, buttonlabel: btnContinue, img: error_icon)
                                            strongSelf.present(alertVC!, animated: true, completion: nil)
                                        }

        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))

        self.present(actionSheet, animated: true)
    }
    
    @IBAction func editProfileAction(_ sender: Any) {
        performSegue(withIdentifier: goEditSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == goEditSegue) {
            let vc = segue.destination as! EditProfileViewController
            vc.dataProfile = self.profile
        }
    }

}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    func setup() {
        
        let buttonImage = UIImage(named: "exit_icon")
        logoutButton.setImage(buttonImage, for: .normal)
        logoutButton.setImageTintColor(colorTomato)
        
        editProfileButton.layer.cornerRadius = 20
        editProfileButton.backgroundColor = actionButtonColor
        editProfileButton.layer.masksToBounds = true
    }
}
