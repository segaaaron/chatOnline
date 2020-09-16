//
//  ProfileViewController.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/16/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    //outlets
    @IBOutlet weak var tableVC: UITableView!
    
    let alert = AlertService()
    var loading: Loading!
    
    var profile = Profile()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        getProfileUser()
        self.loading = Loading()
        self.loading.showLoading(onView: self.view)
    }
    
    func getProfileUser() {
        ProfilePresenter().getProfile(userID: Auth.auth().currentUser!.uid, success: { (profile) in
            self.profile = profile
            self.tableVC.reloadData()
            self.loading.removeLoading()
        }) { (error) in
            print(error!.localizedDescription)
            self.loading.removeLoading()
        }
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        do {
            try FirebaseAuth.Auth.auth().signOut()

            let logginVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginVC")
            let navController = UINavigationController(rootViewController: logginVC)
  
            self.view.window?.rootViewController = navController
        }
        catch {
            let alertVC = self.alert.alert(message: ERROR_LOGOUT, buttonlabel: btnContinue, img: error_icon)
            self.present(alertVC, animated: true, completion: nil)
        }
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kcellProfile, for: indexPath ) as! ProfileCell
        cell.nameLabel.text = self.profile.name
        cell.nameTextField.text = self.profile.name
        cell.contactTextField.text = self.profile.contactNumber
        cell.lastNameTextField.text = self.profile.lastName
        cell.emailTextField.text = self.profile.email
        return cell
    }
    
    func setupCell() {
        self.tableVC.delegate = self
        self.tableVC.dataSource = self
        let cell = UINib(nibName: kcellProfile, bundle: nil)
        
        self.tableVC.register(cell, forCellReuseIdentifier: kcellProfile)
        self.tableVC.separatorStyle = .singleLine
        self.tableVC.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        self.tableVC.separatorColor = UIColor.lightGray
        self.tableVC.tableFooterView = UIView(frame: .zero)
    }
    
}
